# Signature: dev.tswicolly03

param(
  [string]$ApiUrl = "http://localhost:3333",
  [switch]$SkipDocker
)

$ErrorActionPreference = "Stop"

function Step($Message) {
  Write-Host ""
  Write-Host "==> $Message" -ForegroundColor Cyan
}

Step "Tool versions"
flutter --version
dart --version
node --version
npm --version
docker --version
docker compose version

Step "Flutter dependencies"
flutter pub get

Step "Generated code"
flutter pub run build_runner build --delete-conflicting-outputs

Step "Flutter analyze"
flutter analyze

Step "Flutter tests"
flutter test

Step "Flutter Web release build"
flutter build web --release --dart-define=CAMPUSFLOW_API_BASE_URL=$ApiUrl

Step "Backend checks"
Push-Location backend
try {
  npm install

  if (-not $SkipDocker) {
    Step "PostgreSQL"
    docker compose up -d postgres
  }

  Step "Prisma"
  npm run db:generate
  npm run db:push

  Step "Backend build"
  npm run build

  Step "Backend tests"
  npm test

  Step "API checks"
  try {
    Invoke-RestMethod "$ApiUrl/health" | Out-Host
    Invoke-RestMethod "$ApiUrl/ready" | Out-Host
  } catch {
    Write-Warning "API is not responding at $ApiUrl. Start backend with scripts/run_backend_demo.ps1."
  }
} finally {
  Pop-Location
}

Write-Host ""
Write-Host "CampusFlow Demo Release 0.1 check completed." -ForegroundColor Green
