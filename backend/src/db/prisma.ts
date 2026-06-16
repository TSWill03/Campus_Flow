// Signature: dev.tswicolly03

import { PrismaClient } from '@prisma/client';

export function createPrismaClient(): PrismaClient {
  return new PrismaClient();
}
