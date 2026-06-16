// Signature: dev.tswicolly03

import { z } from 'zod';

export const registerSchema = z.object({
  name: z.string().trim().min(2).max(120),
  email: z.string().trim().email().toLowerCase(),
  password: z.string().min(8).max(200)
});

export const loginSchema = z.object({
  email: z.string().trim().email().toLowerCase(),
  password: z.string().min(8).max(200)
});

export const refreshSchema = z.object({
  refreshToken: z.string().min(20)
});

export const forgotPasswordSchema = z.object({
  email: z.string().trim().email().toLowerCase()
});

export const resetPasswordSchema = z.object({
  token: z.string().min(20),
  newPassword: z.string().min(8).max(200)
});

export const googleLoginSchema = z.object({
  idToken: z.string().min(20),
  name: z.string().trim().min(1).max(120).optional()
});
