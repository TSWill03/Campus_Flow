// Signature: dev.tswicolly03

import type { FastifyRequest } from 'fastify';

import { AppError, UnauthorizedError } from './errors.js';
import { timingSafeStringEqual } from './security.js';

export async function requireUserId(request: FastifyRequest): Promise<string> {
  await request.jwtVerify();
  const userId = request.user.sub;
  if (!userId) {
    throw new UnauthorizedError();
  }
  return userId;
}

export function requireAdminToken(request: FastifyRequest): void {
  const configuredToken = request.server.config.ADMIN_API_TOKEN.trim();
  if (!configuredToken) {
    throw new AppError('Admin API token is not configured.', 503, 'admin_token_not_configured');
  }

  const providedToken =
    request.headers['x-admin-token']?.toString() ??
    extractBearerToken(request.headers.authorization);
  if (!providedToken || !timingSafeStringEqual(providedToken, configuredToken)) {
    throw new UnauthorizedError('Admin token invalido.');
  }
}

export async function getOptionalUserId(request: FastifyRequest): Promise<string | null> {
  if (!extractBearerToken(request.headers.authorization)) {
    return null;
  }

  try {
    await request.jwtVerify();
    return request.user.sub || null;
  } catch {
    // Relatorios de erro tambem precisam funcionar quando o token local ficou
    // expirado ou corrompido. Nesse caso o report entra como anonimo.
    return null;
  }
}

function extractBearerToken(header: string | undefined): string | null {
  if (!header) {
    return null;
  }

  const [scheme, token] = header.split(' ');
  if (scheme?.toLowerCase() !== 'bearer' || !token) {
    return null;
  }
  return token.trim() || null;
}
