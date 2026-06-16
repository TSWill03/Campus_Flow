// Signature: dev.tswicolly03

import { z } from 'zod';

export const fileMetadataSchema = z.object({
  entityType: z.string().trim().min(2).max(80),
  entityId: z.string().trim().min(1).max(160),
  category: z.string().trim().min(1).max(80).optional()
});

export const fileListQuerySchema = z.object({
  entityType: z.string().trim().min(2).max(80),
  entityId: z.string().trim().min(1).max(160)
});

export const fileIdParamSchema = z.object({
  id: z.string().uuid()
});
