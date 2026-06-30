// Signature: dev.tswicolly03

import { Prisma } from '@prisma/client';
import type { FastifyInstance } from 'fastify';

import { getOptionalUserId, requireAdminToken } from '../../shared/auth.js';
import { NotFoundError } from '../../shared/errors.js';
import {
  errorReportIdParamSchema,
  errorReportListQuerySchema,
  errorReportSchema,
  errorReportStatusUpdateSchema
} from './feedback.schemas.js';
import { sanitizeExtra, sanitizeReportString } from './feedback.sanitizer.js';

const reportSelect = {
  id: true,
  userId: true,
  type: true,
  severity: true,
  message: true,
  userDescription: true,
  stackTrace: true,
  platform: true,
  appVersion: true,
  buildNumber: true,
  route: true,
  deviceIdHash: true,
  extraJson: true,
  status: true,
  createdAt: true,
  updatedAt: true
} satisfies Prisma.ErrorReportSelect;

export async function registerFeedbackRoutes(app: FastifyInstance) {
  app.post(
    '/feedback/report',
    {
      bodyLimit: 32 * 1024,
      config: {
        rateLimit: {
          max: 20,
          timeWindow: '1 minute'
        }
      }
    },
    async (request) => {
      const userId = await getOptionalUserId(request);
      const body = errorReportSchema.parse(request.body);
      const sanitizedExtra = sanitizeExtra(body.extra);
      const report = await app.prisma.errorReport.create({
        data: {
          userId,
          type: body.type,
          severity: body.severity,
          message: sanitizeReportString(body.message, 1000)!,
          userDescription: sanitizeReportString(body.userDescription, 4000),
          stackTrace: sanitizeReportString(body.stackTrace, 12000),
          platform: sanitizeReportString(body.platform, 80),
          appVersion: sanitizeReportString(body.appVersion, 40),
          buildNumber: sanitizeReportString(body.buildNumber, 40),
          route: sanitizeReportString(body.route, 240),
          deviceIdHash: sanitizeReportString(body.deviceIdHash, 128),
          extraJson: sanitizedExtra ? (sanitizedExtra as Prisma.InputJsonObject) : undefined
        },
        select: {
          id: true
        }
      });

      return {
        reportId: report.id,
        requestId: request.id
      };
    }
  );

  app.get('/admin/error-reports', async (request) => {
    requireAdminToken(request);
    const query = errorReportListQuerySchema.parse(request.query);
    const reports = await app.prisma.errorReport.findMany({
      where: {
        ...(query.status ? { status: query.status } : {}),
        ...(query.severity ? { severity: query.severity } : {}),
        ...(query.type ? { type: query.type } : {})
      },
      orderBy: {
        createdAt: 'desc'
      },
      take: query.limit,
      select: reportSelect
    });

    return {
      reports,
      requestId: request.id
    };
  });

  app.patch('/admin/error-reports/:id/status', async (request) => {
    requireAdminToken(request);
    const params = errorReportIdParamSchema.parse(request.params);
    const body = errorReportStatusUpdateSchema.parse(request.body);
    const report = await app.prisma.errorReport.findUnique({
      where: {
        id: params.id
      },
      select: {
        id: true
      }
    });
    if (!report) {
      throw new NotFoundError('Relatorio nao encontrado.');
    }

    const updated = await app.prisma.errorReport.update({
      where: {
        id: params.id
      },
      data: {
        status: body.status
      },
      select: reportSelect
    });

    return {
      report: updated,
      requestId: request.id
    };
  });
}
