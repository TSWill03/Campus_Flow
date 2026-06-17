// Signature: dev.tswicolly03

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const now = new Date();

try {
  const [refreshTokens, passwordResetTokens] = await Promise.all([
    prisma.refreshToken.deleteMany({
      where: {
        expiresAt: {
          lt: now
        }
      }
    }),
    prisma.passwordResetToken.deleteMany({
      where: {
        OR: [
          {
            expiresAt: {
              lt: now
            }
          },
          {
            usedAt: {
              not: null
            }
          }
        ]
      }
    })
  ]);

  console.log(
    JSON.stringify(
      {
        cleanedAt: now.toISOString(),
        refreshTokensDeleted: refreshTokens.count,
        passwordResetTokensDeleted: passwordResetTokens.count
      },
      null,
      2
    )
  );
} finally {
  await prisma.$disconnect();
}
