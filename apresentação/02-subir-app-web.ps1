# Signature: dev.tswicolly03

param(
  [string]$ApiUrl = "http://localhost:3333",
  [string]$Device = "chrome",
  [string]$WebHostname = "localhost",
  [int]$WebPort = 7357
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

function Step($Message) {
  Write-Host ""
  Write-Host "==> $Message" -ForegroundColor Cyan
}

Push-Location $ProjectRoot
try {
  Step "Flutter dependencies"
  flutter pub get

  Step "Flutter run"
  Write-Host "Device: $Device" -ForegroundColor Green
  Write-Host "API: $ApiUrl" -ForegroundColor Green

  $FlutterArgs = @(
    "run",
    "-d",
    $Device,
    "--dart-define=CAMPUSFLOW_API_BASE_URL=$ApiUrl"
  )

  if ($Device -eq "chrome") {
    $FlutterArgs += @(
      "--web-hostname",
      $WebHostname,
      "--web-port",
      "$WebPort"
    )
  }

  flutter @FlutterArgs
} finally {
  Pop-Location
}

