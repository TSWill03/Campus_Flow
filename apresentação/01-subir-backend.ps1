# Signature: dev.tswicolly03

param(
  [switch]$SeedDemo,
  [switch]$SkipDocker,
  [switch]$NoInstall
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

function Step($Message) {
  Write-Host ""
  Write-Host "==> $Message" -ForegroundColor Cyan
}

Push-Location (Join-Path $ProjectRoot "backend")
try {
  if (-not $NoInstall) {
    Step "Backend dependencies"
    npm install
  }

  if (-not (Test-Path ".env")) {
    Copy-Item ".env.example" ".env"
    Write-Host "Created backend\.env from .env.example." -ForegroundColor Yellow
  } else {
    Write-Host "Keeping existing backend\.env." -ForegroundColor Yellow
  }

  if (-not $SkipDocker) {
    Step "PostgreSQL container"
    docker compose up -d postgres
  }

  Step "Prisma schema"
  npm run db:generate
  npm run db:push

  if ($SeedDemo) {
    Step "Demo seed"
    npm run demo:seed
  }

  Step "API dev server"
  Write-Host "API: http://localhost:3333" -ForegroundColor Green
  npm run dev
} finally {
  Pop-Location
}

