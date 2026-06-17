// Signature: dev.tswicolly03

import 'dotenv/config';
import { z } from 'zod';

const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
  PORT: z.coerce.number().int().positive().default(3333),
  DATABASE_URL: z.string().min(1),
  JWT_SECRET: z.string().min(32),
  ACCESS_TOKEN_TTL_SECONDS: z.coerce.number().int().positive().default(900),
  REFRESH_TOKEN_DAYS: z.coerce.number().int().positive().default(30),
  CORS_ORIGIN: z.string().default('*'),
  GOOGLE_CLIENT_ID: z.string().optional().default(''),
  GOOGLE_CLIENT_IDS: z.string().optional().default(''),
  STORAGE_DIR: z.string().default('storage/uploads')
});

export type AppConfig = z.infer<typeof envSchema> & {
  corsOrigins: string[] | true;
  googleClientIds: string[];
};

export function loadConfig(): AppConfig {
  const parsed = envSchema.parse(process.env);
  if (parsed.NODE_ENV === 'production' && parsed.CORS_ORIGIN.trim() === '*') {
    throw new Error('CORS_ORIGIN must not be "*" in production.');
  }

  return {
    ...parsed,
    googleClientIds: [
      parsed.GOOGLE_CLIENT_ID,
      ...parsed.GOOGLE_CLIENT_IDS.split(',')
    ]
      .map((clientId) => clientId.trim())
      .filter((clientId, index, allClientIds) => clientId !== '' && allClientIds.indexOf(clientId) === index),
    corsOrigins:
      parsed.CORS_ORIGIN.trim() === '*'
        ? true
        : parsed.CORS_ORIGIN.split(',')
            .map((origin) => origin.trim())
            .filter(Boolean)
  };
}
