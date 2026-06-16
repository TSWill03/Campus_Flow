// Signature: dev.tswicolly03

import { createHash, randomUUID } from 'node:crypto';
import { createReadStream } from 'node:fs';
import { mkdir, writeFile } from 'node:fs/promises';
import path from 'node:path';
import type { FastifyInstance } from 'fastify';

import { requireUserId } from '../../shared/auth.js';
import { AppError, NotFoundError } from '../../shared/errors.js';
import { fileIdParamSchema, fileListQuerySchema, fileMetadataSchema } from './file.schemas.js';

export async function registerFileRoutes(app: FastifyInstance) {
  app.post('/files/upload', async (request) => {
    const userId = await requireUserId(request);
    const fields: Record<string, string> = {};
    let fileBuffer: Buffer | null = null;
    let fileName = '';
    let mimeType = 'application/octet-stream';

    for await (const part of request.parts()) {
      if (part.type === 'file') {
        fileName = sanitizeFileName(part.filename || 'arquivo');
        mimeType = part.mimetype || mimeType;
        fileBuffer = await part.toBuffer();
      } else {
        fields[part.fieldname] = String(part.value);
      }
    }

    if (!fileBuffer) {
      throw new AppError('Envie um arquivo no campo "file".');
    }

    const metadata = fileMetadataSchema.parse(fields);
    const checksum = createHash('sha256').update(fileBuffer).digest('hex');
    const storageKey = createStorageKey(userId, fileName);
    const absolutePath = path.join(app.config.STORAGE_DIR, storageKey);

    await mkdir(path.dirname(absolutePath), {
      recursive: true
    });
    await writeFile(absolutePath, fileBuffer);

    const fileObject = await app.prisma.fileObject.create({
      data: {
        userId,
        entityType: metadata.entityType,
        entityId: metadata.entityId,
        category: metadata.category,
        fileName,
        mimeType,
        sizeBytes: fileBuffer.length,
        storageKey,
        checksum
      }
    });

    return {
      file: fileObject
    };
  });

  app.get('/files', async (request) => {
    const userId = await requireUserId(request);
    const query = fileListQuerySchema.parse(request.query);
    const files = await app.prisma.fileObject.findMany({
      where: {
        userId,
        entityType: query.entityType,
        entityId: query.entityId,
        deletedAt: null
      },
      orderBy: {
        createdAt: 'desc'
      }
    });

    return {
      files
    };
  });

  app.get('/files/:id/download', async (request, reply) => {
    const userId = await requireUserId(request);
    const params = fileIdParamSchema.parse(request.params);
    const file = await app.prisma.fileObject.findFirst({
      where: {
        id: params.id,
        userId,
        deletedAt: null
      }
    });
    if (!file) {
      throw new NotFoundError('Arquivo nao encontrado.');
    }

    const absolutePath = path.join(app.config.STORAGE_DIR, file.storageKey);
    reply
      .type(file.mimeType)
      .header('Content-Disposition', `attachment; filename="${encodeURIComponent(file.fileName)}"`);
    return reply.send(createReadStream(absolutePath));
  });

  app.delete('/files/:id', async (request) => {
    const userId = await requireUserId(request);
    const params = fileIdParamSchema.parse(request.params);
    await app.prisma.fileObject.updateMany({
      where: {
        id: params.id,
        userId,
        deletedAt: null
      },
      data: {
        deletedAt: new Date()
      }
    });

    return {
      deleted: true
    };
  });
}

function createStorageKey(userId: string, fileName: string): string {
  const today = new Date().toISOString().slice(0, 10);
  return path.join(userId, today, `${randomUUID()}-${fileName}`);
}

function sanitizeFileName(fileName: string): string {
  return fileName
    .replace(/[/\\?%*:|"<>]/g, '-')
    .replace(/\s+/g, ' ')
    .trim()
    .slice(0, 180);
}
