# Signature: dev.tswicolly03

param(
  [string]$ApiUrl = "http://localhost:3333"
)

$ErrorActionPreference = "Stop"

function Step($Message) {
  Write-Host ""
  Write-Host "==> $Message" -ForegroundColor Cyan
}

Step "Flutter dependencies"
flutter pub get

Step "Generated code"
flutter pub run build_runner build --delete-conflicting-outputs

Step "Flutter analyze"
flutter analyze

Step "Flutter tests"
flutter test

Step "Backend dependencies"
Push-Location backend
try {
  npm install

  Step "Backend build"
  npm run build

  Step "Backend tests"
  npm test
} finally {
  Pop-Location
}

Step "Optional API checks"
try {
  Invoke-RestMethod "$ApiUrl/health" | Out-Host
  Invoke-RestMethod "$ApiUrl/ready" | Out-Host
} catch {
  Write-Warning "API checks failed. Start the backend first or pass -ApiUrl with the published endpoint."
}

Write-Host ""
Write-Host "CampusFlow check completed." -ForegroundColor Green
