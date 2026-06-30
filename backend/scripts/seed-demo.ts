// Signature: dev.tswicolly03

import 'dotenv/config';

import { PrismaClient, type Prisma } from '@prisma/client';

import { hashPassword } from '../src/shared/security.js';

const prisma = new PrismaClient();

const demoEmail = 'demo@example.com';
const demoPassword = 'SenhaDemo123!';
const demoName = 'Demo CampusFlow';

const now = new Date().toISOString();

const demoEntities: Array<{
  entityType: string;
  localId: string;
  payload: Record<string, unknown>;
}> = [
  {
    entityType: 'academic_profile',
    localId: 'demo-profile-cc-ifgoiano',
    payload: {
      id: 'demo-profile-cc-ifgoiano',
      profileName: 'Demo CampusFlow',
      courseName: 'Ciencia da Computacao',
      institution: 'IF Goiano',
      campus: 'Campus Morrinhos',
      degreeLabel: 'Bacharelado',
      isActive: true,
      totalCourseHours: 3200,
      semesterCount: 8,
      requiredComplementaryHours: 120,
      requiredInternshipHours: 160,
      requiredExtensionHours: 320,
      updatedAt: now
    }
  },
  {
    entityType: 'course_subject',
    localId: 'demo-subject-estrutura-dados',
    payload: {
      id: 'demo-subject-estrutura-dados',
      academicProfileId: 'demo-profile-cc-ifgoiano',
      name: 'Estrutura de Dados',
      code: 'CC-ED-01',
      semester: 3,
      workloadHours: 80,
      status: 'in_progress',
      updatedAt: now
    }
  },
  {
    entityType: 'complementary_activity',
    localId: 'demo-activity-campus-party',
    payload: {
      id: 'demo-activity-campus-party',
      academicProfileId: 'demo-profile-cc-ifgoiano',
      title: 'Campus Party / Evento academico',
      type: 'Evento academico',
      hours: 12,
      date: '2026-06-20',
      updatedAt: now
    }
  },
  {
    entityType: 'study_task',
    localId: 'demo-task-matematica-discreta',
    payload: {
      id: 'demo-task-matematica-discreta',
      title: 'Revisar listas de Matematica Discreta',
      description: 'Separar exercicios de grafos, relacoes e inducao.',
      status: 'pending',
      dueDate: '2026-06-27',
      updatedAt: now
    }
  }
];

async function main() {
  const resetOnly = process.argv.includes('--reset-only');

  const existing = await prisma.user.findUnique({
    where: {
      email: demoEmail
    }
  });

  if (existing) {
    await prisma.user.delete({
      where: {
        id: existing.id
      }
    });
  }

  if (resetOnly) {
    console.log(`Demo user removed: ${demoEmail}`);
    return;
  }

  const user = await prisma.user.create({
    data: {
      email: demoEmail,
      name: demoName,
      passwordHash: await hashPassword(demoPassword),
      syncDevices: {
        create: {
          clientId: 'demo-seed-device',
          name: 'CampusFlow Demo Seed'
        }
      },
      syncEntities: {
        create: demoEntities.map((entity) => ({
          entityType: entity.entityType,
          localId: entity.localId,
          version: 1,
          isDeleted: false,
          payload: toJson(entity.payload),
          clientUpdatedAt: new Date(now)
        }))
      }
    }
  });

  console.log(`Demo user ready: ${user.email}`);
  console.log(`Password: ${demoPassword}`);
  console.log(`Seeded sync entities: ${demoEntities.length}`);
}

function toJson(payload: Record<string, unknown>): Prisma.InputJsonValue {
  return JSON.parse(JSON.stringify(payload)) as Prisma.InputJsonValue;
}

main()
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
