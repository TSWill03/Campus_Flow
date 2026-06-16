# Signature: dev.tswicolly03

param(
  [Parameter(Mandatory = $true)]
  [string]$WebClientId,
  [string]$ExtraClientIds = "",
  [string]$HostName = "tswicolly03.duckdns.org",
  [string]$User = "ubuntu",
  [string]$SshKey = $env:CAMPUSFLOW_SSH_KEY
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($SshKey)) {
  throw "Informe a chave SSH com -SshKey ou defina a variavel CAMPUSFLOW_SSH_KEY."
}

if (-not (Test-Path -LiteralPath $SshKey)) {
  throw "Chave SSH nao encontrada no caminho informado."
}

$remote = "$User@$HostName"
$escapedWebClientId = $WebClientId.Replace("'", "'\''")
$escapedExtraClientIds = $ExtraClientIds.Replace("'", "'\''")

$remoteScript = @"
set -euo pipefail

ENV_FILE="/opt/campusflow/backend/.env"
WEB_CLIENT_ID='$escapedWebClientId'
EXTRA_CLIENT_IDS='$escapedExtraClientIds'

if [ ! -f "`$ENV_FILE" ]; then
  echo "Arquivo `$ENV_FILE nao encontrado. Rode o deploy primeiro." >&2
  exit 1
fi

if grep -q '^GOOGLE_CLIENT_ID=' "`$ENV_FILE"; then
  sudo sed -i "s#^GOOGLE_CLIENT_ID=.*#GOOGLE_CLIENT_ID=`$WEB_CLIENT_ID#" "`$ENV_FILE"
else
  echo "GOOGLE_CLIENT_ID=`$WEB_CLIENT_ID" | sudo tee -a "`$ENV_FILE" >/dev/null
fi

if grep -q '^GOOGLE_CLIENT_IDS=' "`$ENV_FILE"; then
  sudo sed -i "s#^GOOGLE_CLIENT_IDS=.*#GOOGLE_CLIENT_IDS=`$EXTRA_CLIENT_IDS#" "`$ENV_FILE"
else
  echo "GOOGLE_CLIENT_IDS=`$EXTRA_CLIENT_IDS" | sudo tee -a "`$ENV_FILE" >/dev/null
fi

sudo systemctl restart campusflow-api
sudo systemctl is-active campusflow-api
echo "Google OAuth atualizado no backend."
"@

$remoteScript | ssh -i $SshKey $remote 'bash -s'

if ($LASTEXITCODE -ne 0) {
  throw "Falha ao configurar Google OAuth no servidor."
}
