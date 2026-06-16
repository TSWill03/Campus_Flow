// Signature: dev.tswicolly03

import type { FastifyReply, FastifyRequest } from 'fastify';
import { ZodError } from 'zod';

import { AppError } from './errors.js';

export function handleHttpError(error: unknown, _request: FastifyRequest, reply: FastifyReply) {
  if (error instanceof ZodError) {
    return reply.status(400).send({
      error: 'validation_error',
      message: 'Invalid request payload.',
      details: error.flatten()
    });
  }

  if (error instanceof AppError) {
    return reply.status(error.statusCode).send({
      error: error.code,
      message: error.message
    });
  }

  const fallback = error instanceof Error ? error.message : 'Unexpected server error.';
  return reply.status(500).send({
    error: 'internal_error',
    message: fallback
  });
}
