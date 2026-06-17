# Signature: dev.tswicolly03

param(
  [string]$ApiUrl = "http://localhost:3333"
)

$ErrorActionPreference = "Stop"

function Step($Message) {
  Write-Host ""
  Write-Host "==> $Message" -ForegroundColor Cyan
}

Step "Node version"
node --version

Step "Install dependencies"
npm install

Step "Prisma generate and TypeScript build"
npm run build

Step "Backend tests"
npm test

Step "Health and readiness checks"
try {
  Invoke-RestMethod "$ApiUrl/health" | Out-Host
  Invoke-RestMethod "$ApiUrl/ready" | Out-Host
} catch {
  Write-Warning "Backend is not responding at $ApiUrl. Start it with npm run dev before checking endpoints."
}

Write-Host ""
Write-Host "Backend check completed." -ForegroundColor Green
