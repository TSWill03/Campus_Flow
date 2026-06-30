#!/usr/bin/env bash
# Signature: dev.tswicolly03

set -euo pipefail

API_URL="${API_URL:-http://localhost:3333}"
SKIP_DOCKER="${SKIP_DOCKER:-0}"

step() {
  printf '\n==> %s\n' "$1"
}

step "Tool versions"
flutter --version
dart --version
node --version
npm --version
docker --version
docker compose version

step "Flutter dependencies"
flutter pub get

step "Generated code"
flutter pub run build_runner build --delete-conflicting-outputs

step "Flutter analyze"
flutter analyze

step "Flutter tests"
flutter test

step "Flutter Web release build"
flutter build web --release --dart-define=CAMPUSFLOW_API_BASE_URL="$API_URL"

step "Backend checks"
pushd backend >/dev/null
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

step "API checks"
if command -v curl >/dev/null 2>&1; then
  curl -fsS "$API_URL/health" || true
  printf '\n'
  curl -fsS "$API_URL/ready" || true
  printf '\n'
fi

popd >/dev/null
printf '\nCampusFlow Demo Release 0.1 check completed.\n'
