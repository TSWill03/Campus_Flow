// Signature: dev.tswicolly03

import { mkdtemp, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { afterEach, describe, expect, it, vi } from 'vitest';

import { buildApp } from '../src/app.js';
import type { AppConfig } from '../src/config/env.js';

const createdDirs: string[] = [];

afterEach(async () => {
  for (const dir of createdDirs.splice(0)) {
    await rm(dir, {
      recursive: true,
      force: true
    });
  }
});

describe('app health and readiness', () => {
  it('returns helpful API metadata at the root route', async () => {
    const app = await buildApp(await testConfig(), {
      prisma: fakePrisma() as never
    });

    const response = await app.inject({
      method: 'GET',
      url: '/'
    });
    await app.close();

    expect(response.statusCode).toBe(200);
    expect(response.json()).toMatchObject({
      status: 'ok',
      service: 'campus-flow-backend',
      endpoints: {
        health: '/health',
        ready: '/ready'
      }
    });
  });

  it('keeps /health as a process liveness check', async () => {
    const app = await buildApp(await testConfig(), {
      prisma: fakePrisma() as never
    });

    const response = await app.inject({
      method: 'GET',
      url: '/health'
    });
    await app.close();

    expect(response.statusCode).toBe(200);
    expect(response.json()).toMatchObject({
      status: 'ok',
      service: 'campus-flow-backend'
    });
  });

  it('returns /ready only when database and storage are available', async () => {
    const prisma = fakePrisma();
    const app = await buildApp(await testConfig(), {
      prisma: prisma as never
    });

    const response = await app.inject({
      method: 'GET',
      url: '/ready'
    });
    await app.close();

    expect(response.statusCode).toBe(200);
    expect(response.json()).toMatchObject({
      status: 'ready',
      checks: {
        database: 'ok',
        storage: 'ok'
      }
    });
    expect(prisma.$queryRaw).toHaveBeenCalled();
  });

  it('hides internal error details in production responses', async () => {
    const app = await buildApp(await testConfig({ NODE_ENV: 'production' }), {
      prisma: fakePrisma() as never
    });
    app.get('/boom', async () => {
      throw new Error('internal implementation detail');
    });

    const response = await app.inject({
      method: 'GET',
      url: '/boom'
    });
    await app.close();

    expect(response.statusCode).toBe(500);
    expect(response.json()).toMatchObject({
      requestId: expect.any(String),
      error: 'internal_error',
      message: 'Erro interno do servidor.'
    });
  });

  it('keeps malformed JSON as a client error instead of a 500', async () => {
    const app = await buildApp(await testConfig(), {
      prisma: fakePrisma() as never
    });

    const response = await app.inject({
      method: 'POST',
      url: '/auth/login',
      headers: {
        'content-type': 'application/json'
      },
      payload: '{"email":'
    });
    await app.close();

    expect(response.statusCode).toBe(400);
    expect(response.json()).toMatchObject({
      requestId: expect.any(String),
      error: 'FST_ERR_CTP_INVALID_JSON_BODY',
      message: 'JSON invalido no corpo da requisicao.'
    });
  });
});

async function testConfig(
  overrides: Partial<AppConfig> = {}
): Promise<AppConfig> {
  const storageDir = await mkdtemp(path.join(tmpdir(), 'campusflow-ready-'));
  createdDirs.push(storageDir);

  return {
    NODE_ENV: 'test',
    PORT: 3333,
    DATABASE_URL: 'postgresql://test:test@localhost:5432/test',
    JWT_SECRET: 'test-secret-with-at-least-32-characters',
    ACCESS_TOKEN_TTL_SECONDS: 900,
    REFRESH_TOKEN_DAYS: 30,
    CORS_ORIGIN: 'http://localhost:*',
    GOOGLE_CLIENT_ID: '',
    GOOGLE_CLIENT_IDS: '',
    STORAGE_DIR: storageDir,
    ADMIN_API_TOKEN: 'admin-test-token-with-safe-length',
    corsOrigins: ['http://localhost:*'],
    googleClientIds: [],
    ...overrides
  };
}

function fakePrisma() {
  return {
    $queryRaw: vi.fn().mockResolvedValue([{ '?column?': 1 }]),
    $disconnect: vi.fn()
  };
}
