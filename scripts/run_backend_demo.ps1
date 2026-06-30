# Signature: dev.tswicolly03

param(
  [switch]$SeedDemo
)

$ErrorActionPreference = "Stop"

Push-Location backend
try {
  npm install
  Copy-Item .env.example .env -Force
  docker compose up -d postgres
  npm run db:generate
  npm run db:push

  if ($SeedDemo) {
    npm run demo:seed
  }

  npm run dev
} finally {
  Pop-Location
}
