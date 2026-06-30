#!/usr/bin/env bash
# Signature: dev.tswicolly03

set -euo pipefail

API_URL="${API_URL:-http://localhost:3333}"
SKIP_DOCKER="${SKIP_DOCKER:-0}"

step() {
  printf '\n==> %s\n' "$1"
}

step "Node and npm"
node --version
npm --version

step "Install dependencies"
npm install

if [ "$SKIP_DOCKER" != "1" ]; then
  step "PostgreSQL"
  docker compose up -d postgres
fi

step "Prisma"
npm run db:generate
npm run db:push

step "Backend build"
npm run build

step "Backend tests"
npm test

step "Health and readiness"
if command -v curl >/dev/null 2>&1; then
  curl -fsS "$API_URL/health" || true
  printf '\n'
  curl -fsS "$API_URL/ready" || true
  printf '\n'
fi

printf '\nBackend check completed.\n'
