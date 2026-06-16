// Signature: dev.tswicolly03

import { z } from 'zod';

const syncDateTimeSchema = z.string().datetime({
  local: true,
  offset: true
});

export const syncEntityTypeSchema = z
  .string()
  .trim()
  .min(2)
  .max(80)
  .regex(/^[a-zA-Z][a-zA-Z0-9_.-]*$/);

export const syncChangeSchema = z.object({
  entityType: syncEntityTypeSchema,
  localId: z.string().trim().min(1).max(160),
  remoteId: z.string().trim().min(1).optional(),
  baseVersion: z.number().int().positive().optional(),
  isDeleted: z.boolean().default(false),
  updatedAt: syncDateTimeSchema.optional(),
  payload: z.record(z.string(), z.unknown()).default({})
});

export const syncPushSchema = z.object({
  clientId: z.string().trim().min(4).max(160),
  deviceName: z.string().trim().min(1).max(120).optional(),
  changes: z.array(syncChangeSchema).max(500)
});

export const syncPullQuerySchema = z.object({
  cursor: syncDateTimeSchema.optional(),
  limit: z.coerce.number().int().positive().max(1000).default(200)
});
