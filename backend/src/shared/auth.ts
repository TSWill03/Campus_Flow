// Signature: dev.tswicolly03

import type { FastifyRequest } from 'fastify';

import { UnauthorizedError } from './errors.js';

export async function requireUserId(request: FastifyRequest): Promise<string> {
  await request.jwtVerify();
  const userId = request.user.sub;
  if (!userId) {
    throw new UnauthorizedError();
  }
  return userId;
}
