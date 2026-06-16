// Signature: dev.tswicolly03

import { describe, expect, it } from 'vitest';

import { hasVersionConflict } from '../src/modules/sync/sync.service.js';

describe('sync conflict policy', () => {
  it('accepts changes when the client has the current server version', () => {
    expect(hasVersionConflict(3, 3)).toBe(false);
  });

  it('marks a conflict when the client edits an old version', () => {
    expect(hasVersionConflict(2, 3)).toBe(true);
  });

  it('accepts first sync changes without a base version', () => {
    expect(hasVersionConflict(undefined, 3)).toBe(false);
  });
});
