// Signature: dev.tswicolly03

import type { FastifyInstance } from 'fastify';
import { Prisma } from '@prisma/client';

import type { syncChangeSchema } from './sync.schemas.js';
import type { z } from 'zod';

type SyncChangeInput = z.infer<typeof syncChangeSchema>;

type SyncAcceptedChange = {
  status: 'accepted';
  entityType: string;
  localId: string;
  remoteId: string;
  version: number;
  updatedAt: Date;
};

type SyncConflict = {
  status: 'conflict';
  entityType: string;
  localId: string;
  remoteId: string;
  serverVersion: number;
  serverUpdatedAt: Date;
  serverPayload: unknown;
};

export type SyncPushResult = SyncAcceptedChange | SyncConflict;

// Conflito simples por versao: se o cliente editou em cima de uma versao antiga,
// o servidor devolve o payload atual para revisao/resolucao futura.
export function hasVersionConflict(baseVersion: number | undefined, serverVersion: number | undefined): boolean {
  return baseVersion !== undefined && serverVersion !== undefined && baseVersion < serverVersion;
}

export async function touchSyncDevice(
  app: FastifyInstance,
  input: { userId: string; clientId: string; deviceName?: string }
) {
  await app.prisma.syncDevice.upsert({
    where: {
      userId_clientId: {
        userId: input.userId,
        clientId: input.clientId
      }
    },
    create: {
      userId: input.userId,
      clientId: input.clientId,
      name: input.deviceName,
      lastSeenAt: new Date()
    },
    update: {
      name: input.deviceName,
      lastSeenAt: new Date()
    }
  });
}

export async function pushChanges(
  app: FastifyInstance,
  input: { userId: string; clientId: string; deviceName?: string; changes: SyncChangeInput[] }
): Promise<{ serverTime: Date; results: SyncPushResult[] }> {
  await touchSyncDevice(app, input);

  // Cada mudanca e aplicada de forma independente para que uma falha/conflito
  // nao derrube o lote inteiro de sincronizacao.
  const results: SyncPushResult[] = [];
  for (const change of input.changes) {
    const result = await applyChange(app, input.userId, change);
    results.push(result);
  }

  return {
    serverTime: new Date(),
    results
  };
}

export async function pullChanges(
  app: FastifyInstance,
  input: { userId: string; cursor?: string; limit: number }
) {
  const cursorDate = input.cursor ? new Date(input.cursor) : new Date(0);
  const changes = await app.prisma.syncEntity.findMany({
    where: {
      userId: input.userId,
      updatedAt: {
        gt: cursorDate
      }
    },
    orderBy: {
      updatedAt: 'asc'
    },
    take: input.limit
  });

  return {
    serverTime: new Date(),
    changes: changes.map((entity) => ({
      entityType: entity.entityType,
      localId: entity.localId,
      remoteId: entity.id,
      version: entity.version,
      isDeleted: entity.isDeleted,
      updatedAt: entity.updatedAt,
      payload: entity.payload
    }))
  };
}

async function applyChange(
  app: FastifyInstance,
  userId: string,
  change: SyncChangeInput
): Promise<SyncPushResult> {
  const existing = await app.prisma.syncEntity.findFirst({
    where: change.remoteId
      ? {
          id: change.remoteId,
          userId
        }
      : {
          userId,
          entityType: change.entityType,
          localId: change.localId
        }
  });

  if (hasVersionConflict(change.baseVersion, existing?.version)) {
    return {
      status: 'conflict',
      entityType: change.entityType,
      localId: change.localId,
      remoteId: existing!.id,
      serverVersion: existing!.version,
      serverUpdatedAt: existing!.updatedAt,
      serverPayload: existing!.payload
    };
  }

  const clientUpdatedAt = change.updatedAt ? new Date(change.updatedAt) : undefined;

  if (!existing) {
    const created = await app.prisma.syncEntity.create({
      data: {
        userId,
        entityType: change.entityType,
        localId: change.localId,
        version: 1,
        isDeleted: change.isDeleted,
        payload: toJsonPayload(change.payload),
        clientUpdatedAt
      }
    });
    return {
      status: 'accepted',
      entityType: created.entityType,
      localId: created.localId,
      remoteId: created.id,
      version: created.version,
      updatedAt: created.updatedAt
    };
  }

  const updated = await app.prisma.syncEntity.update({
    where: {
      id: existing.id
    },
    data: {
      version: {
        increment: 1
      },
      isDeleted: change.isDeleted,
      payload: toJsonPayload(change.payload),
      clientUpdatedAt
    }
  });

  return {
    status: 'accepted',
    entityType: updated.entityType,
    localId: updated.localId,
    remoteId: updated.id,
    version: updated.version,
    updatedAt: updated.updatedAt
  };
}

function toJsonPayload(payload: Record<string, unknown>): Prisma.InputJsonValue {
  return JSON.parse(JSON.stringify(payload)) as Prisma.InputJsonValue;
}
