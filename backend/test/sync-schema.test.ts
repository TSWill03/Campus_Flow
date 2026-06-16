// Signature: dev.tswicolly03

import { describe, expect, it } from 'vitest';

import { syncPushSchema } from '../src/modules/sync/sync.schemas.js';

describe('sync schema', () => {
  it('accepts CampusFlow entity names and local Flutter datetimes', () => {
    const parsed = syncPushSchema.parse({
      clientId: 'device-123',
      deviceName: 'CampusFlow',
      changes: [
        {
          entityType: 'academic_profile',
          localId: 'local-profile-id',
          updatedAt: '2026-04-26T01:10:00.000',
          isDeleted: false,
          payload: {
            updatedAt: '2026-04-26T01:10:00.000',
            courseName: 'Ciencia da Computacao'
          }
        }
      ]
    });

    expect(parsed.changes[0]?.entityType).toBe('academic_profile');
  });
});
