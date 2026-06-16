// Signature: dev.tswicolly03

import cors from '@fastify/cors';
import jwt from '@fastify/jwt';
import multipart from '@fastify/multipart';
import type { PrismaClient } from '@prisma/client';
import Fastify, { type FastifyInstance } from 'fastify';

import type { AppConfig } from './config/env.js';
import { createPrismaClient } from './db/prisma.js';
import { registerAuthRoutes } from './modules/auth/auth.routes.js';
import { registerFileRoutes } from './modules/files/file.routes.js';
import { registerSyncRoutes } from './modules/sync/sync.routes.js';
import { handleHttpError } from './shared/http.js';

export type AppServices = {
  prisma?: PrismaClient;
};

// Factory da API. Testes podem injetar um Prisma fake/isolado pelo parametro
// services, enquanto producao usa o cliente real criado em createPrismaClient.
export async function buildApp(config: AppConfig, services: AppServices = {}): Promise<FastifyInstance> {
  const app = Fastify({
    logger: config.NODE_ENV !== 'test'
  });
  const prisma = services.prisma ?? createPrismaClient();

  app.decorate('prisma', prisma);
  app.decorate('config', config);

  await app.register(cors, {
    origin: (origin, callback) => {
      // A lista de CORS aceita dominios fixos e localhost com porta dinamica,
      // necessario para Flutter Web em desenvolvimento.
      callback(null, isCorsOriginAllowed(origin, config.corsOrigins));
    },
    credentials: true
  });
  await app.register(jwt, {
    secret: config.JWT_SECRET
  });
  await app.register(multipart, {
    limits: {
      files: 8,
      fileSize: 25 * 1024 * 1024
    }
  });

  app.setErrorHandler(handleHttpError);

  app.get('/health', async () => ({
    status: 'ok',
    service: 'campus-flow-backend',
    time: new Date().toISOString()
  }));

  await registerAuthRoutes(app);
  await registerSyncRoutes(app);
  await registerFileRoutes(app);

  app.addHook('onClose', async () => {
    await prisma.$disconnect();
  });

  return app;
}

function isCorsOriginAllowed(origin: string | undefined, allowedOrigins: string[] | true): boolean {
  if (!origin || allowedOrigins === true) {
    return true;
  }

  return allowedOrigins.some((allowedOrigin) => {
    if (allowedOrigin === origin) {
      return true;
    }
    if (!allowedOrigin.endsWith(':*')) {
      return false;
    }

    const prefix = allowedOrigin.slice(0, -1);
    const dynamicPort = origin.slice(prefix.length);
    return origin.startsWith(prefix) && /^\d+$/.test(dynamicPort);
  });
}

declare module 'fastify' {
  interface FastifyInstance {
    prisma: PrismaClient;
    config: AppConfig;
  }
}

declare module '@fastify/jwt' {
  interface FastifyJWT {
    payload: {
      sub: string;
      email: string;
    };
    user: {
      sub: string;
      email: string;
    };
  }
}
