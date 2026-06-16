// Signature: dev.tswicolly03

import type { FastifyInstance } from 'fastify';

import { requireUserId } from '../../shared/auth.js';
import { pullChanges, pushChanges } from './sync.service.js';
import { syncPullQuerySchema, syncPushSchema } from './sync.schemas.js';

export async function registerSyncRoutes(app: FastifyInstance) {
  app.post('/sync/push', async (request) => {
    const userId = await requireUserId(request);
    const body = syncPushSchema.parse(request.body);
    return pushChanges(app, {
      userId,
      clientId: body.clientId,
      deviceName: body.deviceName,
      changes: body.changes
    });
  });

  app.get('/sync/pull', async (request) => {
    const userId = await requireUserId(request);
    const query = syncPullQuerySchema.parse(request.query);
    return pullChanges(app, {
      userId,
      cursor: query.cursor,
      limit: query.limit
    });
  });
}
