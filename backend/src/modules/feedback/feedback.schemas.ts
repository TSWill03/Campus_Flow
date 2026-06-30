// Signature: dev.tswicolly03

import { z } from 'zod';

export const errorReportTypeSchema = z.enum([
  'crash',
  'error',
  'feedback',
  'sync_error',
  'login_error'
]);

export const errorReportSeveritySchema = z.enum(['low', 'medium', 'high', 'critical']);

export const errorReportStatusSchema = z.enum(['open', 'triaged', 'resolved', 'ignored']);

const extraSchema = z
  .record(z.string(), z.unknown())
  .optional()
  .superRefine((value, ctx) => {
    if (value === undefined) {
      return;
    }
    const serialized = JSON.stringify(value);
    if (serialized.length > 6000) {
      ctx.addIssue({
        code: 'custom',
        message: 'extra must be smaller than 6000 serialized characters'
      });
    }
  });

export const errorReportSchema = z
  .object({
    type: errorReportTypeSchema,
    severity: errorReportSeveritySchema,
    message: z.string().trim().min(1).max(1000),
    userDescription: z.string().trim().max(4000).optional(),
    stackTrace: z.string().max(12000).optional(),
    platform: z.string().trim().max(80).optional(),
    appVersion: z.string().trim().max(40).optional(),
    buildNumber: z.string().trim().max(40).optional(),
    route: z.string().trim().max(240).optional(),
    deviceIdHash: z.string().trim().max(128).optional(),
    extra: extraSchema
  })
  .strict();

export const errorReportListQuerySchema = z.object({
  status: errorReportStatusSchema.optional(),
  severity: errorReportSeveritySchema.optional(),
  type: errorReportTypeSchema.optional(),
  limit: z.coerce.number().int().positive().max(100).default(50)
});

export const errorReportIdParamSchema = z.object({
  id: z.string().uuid()
});

export const errorReportStatusUpdateSchema = z.object({
  status: errorReportStatusSchema
});
