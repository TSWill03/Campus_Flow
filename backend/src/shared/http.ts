// Signature: dev.tswicolly03

import type { FastifyReply, FastifyRequest } from 'fastify';
import { ZodError } from 'zod';

import { AppError } from './errors.js';

export function handleHttpError(error: unknown, request: FastifyRequest, reply: FastifyReply) {
  const requestId = request.id;

  if (error instanceof ZodError) {
    return reply.status(400).send({
      requestId,
      error: 'validation_error',
      message: 'Invalid request payload.',
      details: error.flatten()
    });
  }

  if (error instanceof AppError) {
    return reply.status(error.statusCode).send({
      requestId,
      error: error.code,
      message: error.message
    });
  }

  if (isFastifyClientError(error)) {
    return reply.status(error.statusCode).send({
      requestId,
      error: error.code ?? 'bad_request',
      message:
        error.code === 'FST_ERR_CTP_INVALID_JSON_BODY'
          ? 'JSON invalido no corpo da requisicao.'
          : error.message
    });
  }

  request.log.error(
    {
      requestId,
      method: request.method,
      route: request.routeOptions.url ?? request.url,
      userId: request.user?.sub,
      statusCode: 500,
      errorType: error instanceof Error ? error.name : typeof error
    },
    'Unhandled request error'
  );
  const fallback = error instanceof Error ? error.message : 'Unexpected server error.';
  const message = request.server.config.NODE_ENV === 'production' ? 'Erro interno do servidor.' : fallback;
  return reply.status(500).send({
    requestId,
    error: 'internal_error',
    message
  });
}

type FastifyClientError = Error & {
  code?: string;
  statusCode: number;
};

function isFastifyClientError(error: unknown): error is FastifyClientError {
  if (!(error instanceof Error)) {
    return false;
  }

  const statusCode = (error as { statusCode?: unknown }).statusCode;
  return typeof statusCode === 'number' && statusCode >= 400 && statusCode < 500;
}
