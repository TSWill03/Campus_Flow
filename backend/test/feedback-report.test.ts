// Signature: dev.tswicolly03

import { mkdtemp, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { afterEach, describe, expect, it, vi } from 'vitest';

import { buildApp } from '../src/app.js';
import type { AppConfig } from '../src/config/env.js';
import { errorReportSchema } from '../src/modules/feedback/feedback.schemas.js';

const createdDirs: string[] = [];

afterEach(async () => {
  for (const dir of createdDirs.splice(0)) {
    await rm(dir, {
      recursive: true,
      force: true
    });
  }
});

describe('feedback error reports', () => {
  it('validates the report schema and rejects oversized fields', () => {
    expect(
      errorReportSchema.parse({
        type: 'sync_error',
        severity: 'medium',
        message: 'Falha ao sincronizar fila local.',
        extra: {
          pendingCount: 2
        }
      })
    ).toMatchObject({
      type: 'sync_error',
      severity: 'medium'
    });

    expect(() =>
      errorReportSchema.parse({
        type: 'error',
        severity: 'low',
        message: 'x'.repeat(1001)
      })
    ).toThrow();
  });

  it('accepts anonymous reports and stores a sanitized payload', async () => {
    const prisma = fakePrisma();
    prisma.errorReport.create.mockResolvedValue({
      id: 'report-123'
    });
    const app = await buildApp(await testConfig(), {
      prisma: prisma as never
    });

    const response = await app.inject({
      method: 'POST',
      url: '/feedback/report',
      payload: {
        type: 'crash',
        severity: 'high',
        message: 'Unhandled exception',
        stackTrace: 'Authorization: Bearer raw-token-value',
        extra: {
          password: 'secret',
          route: '/settings'
        }
      }
    });
    await app.close();

    expect(response.statusCode).toBe(200);
    expect(response.json()).toMatchObject({
      reportId: 'report-123',
      requestId: expect.any(String)
    });
    expect(prisma.errorReport.create).toHaveBeenCalledWith(
      expect.objectContaining({
        data: expect.objectContaining({
          userId: null,
          stackTrace: expect.stringContaining('Bearer [REDACTED]'),
          extraJson: expect.objectContaining({
            password: '[REDACTED]',
            route: '/settings'
          })
        })
      })
    );
  });

  it('protects admin listing with ADMIN_API_TOKEN', async () => {
    const prisma = fakePrisma();
    prisma.errorReport.findMany.mockResolvedValue([]);
    const app = await buildApp(await testConfig(), {
      prisma: prisma as never
    });

    const denied = await app.inject({
      method: 'GET',
      url: '/admin/error-reports'
    });
    const allowed = await app.inject({
      method: 'GET',
      url: '/admin/error-reports?status=open&severity=high&type=crash',
      headers: {
        'x-admin-token': 'admin-test-token-with-safe-length'
      }
    });
    await app.close();

    expect(denied.statusCode).toBe(401);
    expect(allowed.statusCode).toBe(200);
    expect(allowed.json()).toMatchObject({
      reports: [],
      requestId: expect.any(String)
    });
    expect(prisma.errorReport.findMany).toHaveBeenCalledWith(
      expect.objectContaining({
        where: {
          status: 'open',
          severity: 'high',
          type: 'crash'
        },
        take: 50
      })
    );
  });

  it('updates admin report status with a valid token', async () => {
    const prisma = fakePrisma();
    prisma.errorReport.findUnique.mockResolvedValue({
      id: '52fa844e-2c8b-42f7-b7c8-02b735af6af8'
    });
    prisma.errorReport.update.mockResolvedValue({
      id: '52fa844e-2c8b-42f7-b7c8-02b735af6af8',
      status: 'triaged'
    });
    const app = await buildApp(await testConfig(), {
      prisma: prisma as never
    });

    const response = await app.inject({
      method: 'PATCH',
      url: '/admin/error-reports/52fa844e-2c8b-42f7-b7c8-02b735af6af8/status',
      headers: {
        authorization: 'Bearer admin-test-token-with-safe-length'
      },
      payload: {
        status: 'triaged'
      }
    });
    await app.close();

    expect(response.statusCode).toBe(200);
    expect(response.json()).toMatchObject({
      report: {
        status: 'triaged'
      },
      requestId: expect.any(String)
    });
  });
});

async function testConfig(overrides: Partial<AppConfig> = {}): Promise<AppConfig> {
  const storageDir = await mkdtemp(path.join(tmpdir(), 'campusflow-feedback-'));
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
    $disconnect: vi.fn(),
    errorReport: {
      create: vi.fn(),
      findMany: vi.fn(),
      findUnique: vi.fn(),
      update: vi.fn()
    }
  };
}
