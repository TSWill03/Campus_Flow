// Signature: dev.tswicolly03

import type { FastifyInstance } from 'fastify';

import { AppError, UnauthorizedError } from '../../shared/errors.js';
import { createRandomToken, hashPassword, hashToken, verifyPassword } from '../../shared/security.js';

type TokenPair = {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
};

type AuthUser = {
  id: string;
  email: string;
  name: string;
  googleEmail: string | null;
  createdAt: Date;
};

type GoogleTokenInfo = {
  sub: string;
  aud: string;
  email: string;
  email_verified: string | boolean;
  name?: string;
};

// A API nunca devolve hash de senha, tokens persistidos ou campos internos. Este
// mapper deixa claro qual formato seguro vai para o app.
function toAuthUser(user: AuthUser): AuthUser {
  return {
    id: user.id,
    email: user.email,
    name: user.name,
    googleEmail: user.googleEmail,
    createdAt: user.createdAt
  };
}

export async function issueTokenPair(app: FastifyInstance, user: { id: string; email: string }): Promise<TokenPair> {
  const accessToken = app.jwt.sign(
    {
      sub: user.id,
      email: user.email
    },
    {
      expiresIn: app.config.ACCESS_TOKEN_TTL_SECONDS
    }
  );
  const refreshToken = createRandomToken();
  const expiresAt = new Date(Date.now() + app.config.REFRESH_TOKEN_DAYS * 24 * 60 * 60 * 1000);

  // O refresh token bruto so volta uma vez para o cliente. No banco fica apenas
  // o hash, reduzindo impacto caso a base seja exposta.
  await app.prisma.refreshToken.create({
    data: {
      userId: user.id,
      tokenHash: hashToken(refreshToken),
      expiresAt
    }
  });

  return {
    accessToken,
    refreshToken,
    expiresIn: app.config.ACCESS_TOKEN_TTL_SECONDS
  };
}

export async function registerWithPassword(
  app: FastifyInstance,
  input: { name: string; email: string; password: string }
) {
  const existing = await app.prisma.user.findUnique({
    where: {
      email: input.email
    }
  });
  if (existing) {
    // Email e unico por usuario. Dois cadastros iguais retornam 409 para evitar
    // contas duplicadas e confusao na sincronizacao.
    throw new AppError('Este email ja esta cadastrado.', 409, 'email_already_registered');
  }

  const user = await app.prisma.user.create({
    data: {
      name: input.name,
      email: input.email,
      passwordHash: await hashPassword(input.password)
    }
  });

  return {
    user: toAuthUser(user),
    tokens: await issueTokenPair(app, user)
  };
}

export async function loginWithPassword(
  app: FastifyInstance,
  input: { email: string; password: string }
) {
  const user = await app.prisma.user.findUnique({
    where: {
      email: input.email
    }
  });
  if (!user?.passwordHash) {
    throw new UnauthorizedError('Email ou senha invalidos.');
  }

  const isValid = await verifyPassword(input.password, user.passwordHash);
  if (!isValid) {
    throw new UnauthorizedError('Email ou senha invalidos.');
  }

  return {
    user: toAuthUser(user),
    tokens: await issueTokenPair(app, user)
  };
}

export async function refreshAccessToken(app: FastifyInstance, refreshToken: string) {
  const stored = await app.prisma.refreshToken.findUnique({
    where: {
      tokenHash: hashToken(refreshToken)
    },
    include: {
      user: true
    }
  });
  if (!stored || stored.revokedAt || stored.expiresAt.getTime() < Date.now()) {
    throw new UnauthorizedError('Refresh token invalido ou expirado.');
  }

  await app.prisma.refreshToken.update({
    where: {
      id: stored.id
    },
    data: {
      revokedAt: new Date()
    }
  });

  return {
    user: toAuthUser(stored.user),
    tokens: await issueTokenPair(app, stored.user)
  };
}

export async function revokeRefreshToken(app: FastifyInstance, refreshToken: string) {
  await app.prisma.refreshToken.updateMany({
    where: {
      tokenHash: hashToken(refreshToken),
      revokedAt: null
    },
    data: {
      revokedAt: new Date()
    }
  });
}

export async function createPasswordReset(app: FastifyInstance, email: string) {
  const user = await app.prisma.user.findUnique({
    where: {
      email
    }
  });
  if (!user) {
    return {
      sent: true,
      devResetToken: null
    };
  }

  const token = createRandomToken();
  await app.prisma.passwordResetToken.create({
    data: {
      userId: user.id,
      tokenHash: hashToken(token),
      expiresAt: new Date(Date.now() + 30 * 60 * 1000)
    }
  });

  return {
    sent: true,
    devResetToken: app.config.NODE_ENV === 'production' ? null : token
  };
}

export async function resetPassword(
  app: FastifyInstance,
  input: { token: string; newPassword: string }
) {
  const stored = await app.prisma.passwordResetToken.findUnique({
    where: {
      tokenHash: hashToken(input.token)
    }
  });
  if (!stored || stored.usedAt || stored.expiresAt.getTime() < Date.now()) {
    throw new AppError('Token de recuperacao invalido ou expirado.', 400, 'invalid_reset_token');
  }

  await app.prisma.$transaction([
    app.prisma.user.update({
      where: {
        id: stored.userId
      },
      data: {
        passwordHash: await hashPassword(input.newPassword)
      }
    }),
    app.prisma.passwordResetToken.update({
      where: {
        id: stored.id
      },
      data: {
        usedAt: new Date()
      }
    }),
    app.prisma.refreshToken.updateMany({
      where: {
        userId: stored.userId,
        revokedAt: null
      },
      data: {
        revokedAt: new Date()
      }
    })
  ]);

  return {
    reset: true
  };
}

export async function loginWithGoogle(app: FastifyInstance, idToken: string, fallbackName?: string) {
  if (app.config.googleClientIds.length === 0) {
    throw new AppError('Login com Google ainda nao foi configurado no servidor.', 501, 'google_not_configured');
  }

  const info = await verifyGoogleToken(app.config.googleClientIds, idToken);
  const email = info.email.toLowerCase();
  const name = info.name?.trim() || fallbackName?.trim() || email.split('@')[0];

  // Google entra pelo mesmo email da conta tradicional. Se o email ja existe, a
  // conta e vinculada/atualizada; se nao existe, uma nova conta e criada.
  const user = await app.prisma.user.upsert({
    where: {
      email
    },
    create: {
      email,
      name,
      googleSubject: info.sub,
      googleEmail: email
    },
    update: {
      googleSubject: info.sub,
      googleEmail: email,
      name
    }
  });

  return {
    user: toAuthUser(user),
    tokens: await issueTokenPair(app, user)
  };
}

async function verifyGoogleToken(clientIds: string[], idToken: string): Promise<GoogleTokenInfo> {
  const response = await fetch(`https://oauth2.googleapis.com/tokeninfo?id_token=${encodeURIComponent(idToken)}`);
  if (!response.ok) {
    throw new UnauthorizedError('Token do Google invalido.');
  }

  const payload = (await response.json()) as GoogleTokenInfo;
  const verified = payload.email_verified === true || payload.email_verified === 'true';
  if (!clientIds.includes(payload.aud) || !payload.email || !verified) {
    throw new UnauthorizedError('Token do Google nao pertence a este aplicativo.');
  }
  return payload;
}
