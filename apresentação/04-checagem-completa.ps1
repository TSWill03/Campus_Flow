# Signature: dev.tswicolly03

param(
  [string]$ApiUrl = "http://localhost:3333",
  [switch]$SkipDocker
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$CheckScript = Join-Path $ProjectRoot "scripts\check_demo.ps1"

Push-Location $ProjectRoot
try {
  & $CheckScript -ApiUrl $ApiUrl -SkipDocker:$SkipDocker
} finally {
  Pop-Location
}

