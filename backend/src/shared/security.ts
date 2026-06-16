// Signature: dev.tswicolly03

import { randomBytes, randomUUID, scrypt as scryptCallback, timingSafeEqual, createHash } from 'node:crypto';
import { promisify } from 'node:util';

const scrypt = promisify(scryptCallback);
const keyLength = 64;

export function createRandomToken(): string {
  return randomBytes(48).toString('base64url');
}

export function createId(): string {
  return randomUUID();
}

export function hashToken(token: string): string {
  return createHash('sha256').update(token).digest('hex');
}

export async function hashPassword(password: string): Promise<string> {
  const salt = randomBytes(24).toString('base64url');
  const derivedKey = (await scrypt(password, salt, keyLength)) as Buffer;
  return `scrypt$${salt}$${derivedKey.toString('base64url')}`;
}

export async function verifyPassword(password: string, storedHash: string): Promise<boolean> {
  const [scheme, salt, key] = storedHash.split('$');
  if (scheme !== 'scrypt' || !salt || !key) {
    return false;
  }

  const expected = Buffer.from(key, 'base64url');
  const actual = (await scrypt(password, salt, expected.length)) as Buffer;
  return expected.length === actual.length && timingSafeEqual(expected, actual);
}
