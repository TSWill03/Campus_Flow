// Signature: dev.tswicolly03

const secretKeyPattern = /(password|senha|token|authorization|cookie|secret|api[_-]?key|refresh)/i;
const bearerPattern = /bearer\s+[a-z0-9._~+/=-]+/gi;
const tokenAssignmentPattern = /\b(accessToken|refreshToken|password|senha|token|secret|apiKey)\b\s*[:=]\s*["']?[^"',\s}]+/gi;

export function sanitizeReportString(value: string | undefined, maxLength: number): string | undefined {
  if (value === undefined) {
    return undefined;
  }

  const redacted = value
    .replace(bearerPattern, 'Bearer [REDACTED]')
    .replace(tokenAssignmentPattern, '$1=[REDACTED]')
    .trim();
  return truncate(redacted, maxLength);
}

export function sanitizeExtra(value: Record<string, unknown> | undefined): Record<string, unknown> | undefined {
  if (value === undefined) {
    return undefined;
  }
  return sanitizeExtraValue(value, 0) as Record<string, unknown>;
}

function sanitizeExtraValue(value: unknown, depth: number): unknown {
  if (depth > 4) {
    return '[truncated-depth]';
  }
  if (typeof value === 'string') {
    return sanitizeReportString(value, 500);
  }
  if (typeof value === 'number' || typeof value === 'boolean' || value === null) {
    return value;
  }
  if (Array.isArray(value)) {
    return value.slice(0, 20).map((item) => sanitizeExtraValue(item, depth + 1));
  }
  if (typeof value !== 'object') {
    return String(value);
  }

  const sanitized: Record<string, unknown> = {};
  for (const [key, child] of Object.entries(value as Record<string, unknown>).slice(0, 30)) {
    const safeKey = truncate(key, 80);
    sanitized[safeKey] = secretKeyPattern.test(key) ? '[REDACTED]' : sanitizeExtraValue(child, depth + 1);
  }
  return sanitized;
}

function truncate(value: string, maxLength: number): string {
  if (value.length <= maxLength) {
    return value;
  }
  return `${value.slice(0, maxLength)}...[truncated]`;
}
