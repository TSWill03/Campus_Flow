# Signature: dev.tswicolly03

param(
  [string]$ApiUrl = "http://localhost:3333",
  [string]$Device = "chrome"
)

$ErrorActionPreference = "Stop"

flutter pub get
flutter run -d $Device --dart-define=CAMPUSFLOW_API_BASE_URL=$ApiUrl
