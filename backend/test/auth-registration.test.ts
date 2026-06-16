// Signature: dev.tswicolly03

import { describe, expect, it, vi } from 'vitest';

import { registerWithPassword } from '../src/modules/auth/auth.service.js';

describe('auth registration', () => {
  it('rejects duplicated emails before creating a second account', async () => {
    const app = {
      prisma: {
        user: {
          findUnique: vi.fn().mockResolvedValue({
            id: 'existing-user',
            email: 'aluno@example.com'
          }),
          create: vi.fn()
        }
      }
    };

    await expect(
      registerWithPassword(app as never, {
        name: 'Aluno',
        email: 'aluno@example.com',
        password: 'senha-forte-123'
      })
    ).rejects.toMatchObject({
      statusCode: 409,
      code: 'email_already_registered',
      message: 'Este email ja esta cadastrado.'
    });
    expect(app.prisma.user.create).not.toHaveBeenCalled();
  });
});
