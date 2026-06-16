// Signature: dev.tswicolly03

import { describe, expect, it } from 'vitest';

import { createRandomToken, hashPassword, hashToken, verifyPassword } from '../src/shared/security.js';

describe('security helpers', () => {
  it('hashes and verifies passwords without storing the raw password', async () => {
    const hash = await hashPassword('senha-forte-123');

    expect(hash).not.toContain('senha-forte-123');
    await expect(verifyPassword('senha-forte-123', hash)).resolves.toBe(true);
    await expect(verifyPassword('senha-errada', hash)).resolves.toBe(false);
  });

  it('hashes refresh tokens deterministically', () => {
    const token = createRandomToken();

    expect(hashToken(token)).toBe(hashToken(token));
    expect(hashToken(token)).not.toBe(token);
  });
});
