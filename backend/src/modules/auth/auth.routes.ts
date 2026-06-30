// Signature: dev.tswicolly03

import type { FastifyInstance } from 'fastify';

import { UnauthorizedError } from '../../shared/errors.js';
import {
  createPasswordReset,
  loginWithGoogle,
  loginWithPassword,
  refreshAccessToken,
  registerWithPassword,
  resetPassword,
  revokeRefreshToken
} from './auth.service.js';
import {
  forgotPasswordSchema,
  googleLoginSchema,
  loginSchema,
  refreshSchema,
  registerSchema,
  resetPasswordSchema
} from './auth.schemas.js';

export async function registerAuthRoutes(app: FastifyInstance) {
  app.post(
    '/auth/register',
    {
      config: {
        rateLimit: {
          max: 10,
          timeWindow: '1 minute'
        }
      }
    },
    async (request) => {
    const body = registerSchema.parse(request.body);
    return registerWithPassword(app, body);
    }
  );

  app.post(
    '/auth/login',
    {
      config: {
        rateLimit: {
          max: 10,
          timeWindow: '1 minute'
        }
      }
    },
    async (request) => {
    const body = loginSchema.parse(request.body);
    return loginWithPassword(app, body);
    }
  );

  app.post('/auth/google', async (request) => {
    const body = googleLoginSchema.parse(request.body);
    return loginWithGoogle(app, body.idToken, body.name);
  });

  app.post('/auth/refresh', async (request) => {
    const body = refreshSchema.parse(request.body);
    return refreshAccessToken(app, body.refreshToken);
  });

  app.post('/auth/logout', async (request) => {
    const body = refreshSchema.parse(request.body);
    await revokeRefreshToken(app, body.refreshToken);
    return {
      revoked: true
    };
  });

  app.post(
    '/auth/password/forgot',
    {
      config: {
        rateLimit: {
          max: 5,
          timeWindow: '1 minute'
        }
      }
    },
    async (request) => {
    const body = forgotPasswordSchema.parse(request.body);
    return createPasswordReset(app, body.email);
    }
  );

  app.post('/auth/password/reset', async (request) => {
    const body = resetPasswordSchema.parse(request.body);
    return resetPassword(app, body);
  });

  app.get('/auth/me', async (request) => {
    await request.jwtVerify();
    const userId = request.user.sub;
    if (!userId) {
      throw new UnauthorizedError();
    }

    const user = await app.prisma.user.findUnique({
      where: {
        id: userId
      },
      select: {
        id: true,
        email: true,
        name: true,
        googleEmail: true,
        createdAt: true
      }
    });
    if (!user) {
      throw new UnauthorizedError();
    }

    return {
      user
    };
  });
}
