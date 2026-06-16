# Signature: dev.tswicolly03

param(
  [string]$HostName = "tswicolly03.duckdns.org",
  [string]$User = "ubuntu",
  [string]$SshKey = $env:CAMPUSFLOW_SSH_KEY
)

$ErrorActionPreference = "Stop"

function Assert-LastCommand {
  param([string]$Step)

  if ($LASTEXITCODE -ne 0) {
    throw "Falha na etapa: $Step"
  }
}

if ([string]::IsNullOrWhiteSpace($SshKey)) {
  throw "Informe a chave SSH com -SshKey ou defina a variavel CAMPUSFLOW_SSH_KEY."
}

if (-not (Test-Path -LiteralPath $SshKey)) {
  throw "Chave SSH nao encontrada no caminho informado."
}

$deployDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$backendDir = Resolve-Path (Join-Path $deployDir "..\..")
$releaseId = Get-Date -Format "yyyyMMddHHmmss"
$archivePath = Join-Path $env:TEMP "campusflow-backend-$releaseId.tar.gz"
$remote = "$User@$HostName"
$remoteArchive = "/tmp/campusflow-backend-$releaseId.tar.gz"
$remoteScriptPath = "/tmp/campusflow-deploy-$releaseId.sh"
$localScriptPath = Join-Path $env:TEMP "campusflow-deploy-$releaseId.sh"

Write-Host "Empacotando backend..."
& tar -czf $archivePath `
  -C $backendDir `
  --exclude=node_modules `
  --exclude=dist `
  --exclude=storage `
  --exclude=coverage `
  --exclude=.env `
  .
Assert-LastCommand "empacotar backend"

$remoteScript = @'
set -euo pipefail

DOMAIN="tswicolly03.duckdns.org"
APP_ROOT="/opt/campusflow/backend"
RELEASE_ID="$(date +%Y%m%d%H%M%S)"
RELEASE_DIR="$APP_ROOT/releases/$RELEASE_ID"
CURRENT_LINK="$APP_ROOT/current"
ENV_FILE="$APP_ROOT/.env"
STORAGE_DIR="$APP_ROOT/storage/uploads"
DB_CONTAINER="campusflow-postgres"
DB_VOLUME="campusflow_postgres"
DB_NAME="campus_flow"
DB_USER="campus_flow"
DB_PORT="5433"
API_PORT="3333"
CORS_VALUE="https://$DOMAIN,http://localhost:*,http://127.0.0.1:*,http://[::1]:*"

sudo mkdir -p "$APP_ROOT/releases" "$STORAGE_DIR"
sudo chown -R ubuntu:ubuntu /opt/campusflow
mkdir -p "$RELEASE_DIR"
tar -xzf "__REMOTE_ARCHIVE__" -C "$RELEASE_DIR"

if [ ! -f "$ENV_FILE" ]; then
  DB_PASSWORD="$(openssl rand -base64 32 | tr '+/' '_-' | tr -d '=')"
  JWT_SECRET="$(openssl rand -base64 64 | tr -d '\n')"
  cat > "$ENV_FILE" <<ENV
NODE_ENV=production
PORT=$API_PORT
DATABASE_URL=postgresql://$DB_USER:$DB_PASSWORD@127.0.0.1:$DB_PORT/$DB_NAME?schema=public
JWT_SECRET=$JWT_SECRET
ACCESS_TOKEN_TTL_SECONDS=900
REFRESH_TOKEN_DAYS=30
CORS_ORIGIN=$CORS_VALUE
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_IDS=
STORAGE_DIR=$STORAGE_DIR
ENV
  chmod 600 "$ENV_FILE"
else
  DB_PASSWORD="$(sed -nE 's#^DATABASE_URL=postgresql://campus_flow:([^@]+)@.*#\1#p' "$ENV_FILE")"
fi

if grep -q '^CORS_ORIGIN=' "$ENV_FILE"; then
  sed -i "s#^CORS_ORIGIN=.*#CORS_ORIGIN=$CORS_VALUE#" "$ENV_FILE"
else
  echo "CORS_ORIGIN=$CORS_VALUE" >> "$ENV_FILE"
fi

if ! grep -q '^GOOGLE_CLIENT_ID=' "$ENV_FILE"; then
  echo "GOOGLE_CLIENT_ID=" >> "$ENV_FILE"
fi

if ! grep -q '^GOOGLE_CLIENT_IDS=' "$ENV_FILE"; then
  echo "GOOGLE_CLIENT_IDS=" >> "$ENV_FILE"
fi

if [ -z "${DB_PASSWORD:-}" ]; then
  echo "Nao foi possivel obter a senha do PostgreSQL em $ENV_FILE." >&2
  exit 1
fi

if ! sudo docker inspect "$DB_CONTAINER" >/dev/null 2>&1; then
  sudo docker volume create "$DB_VOLUME" >/dev/null
  sudo docker run -d --name "$DB_CONTAINER" --restart unless-stopped \
    -e POSTGRES_DB="$DB_NAME" \
    -e POSTGRES_USER="$DB_USER" \
    -e POSTGRES_PASSWORD="$DB_PASSWORD" \
    -p 127.0.0.1:$DB_PORT:5432 \
    -v "$DB_VOLUME":/var/lib/postgresql/data \
    postgres:17-alpine >/dev/null
else
  sudo docker start "$DB_CONTAINER" >/dev/null
fi

for i in $(seq 1 30); do
  if sudo docker exec "$DB_CONTAINER" pg_isready -U "$DB_USER" -d "$DB_NAME" >/dev/null 2>&1; then
    break
  fi
  sleep 2
  if [ "$i" = "30" ]; then
    echo "PostgreSQL nao ficou pronto a tempo." >&2
    exit 1
  fi
done

cd "$RELEASE_DIR"
set -a
. "$ENV_FILE"
set +a
npm install --include=dev
npm run build
npx prisma db push
npm prune --omit=dev
ln -sfn "$RELEASE_DIR" "$CURRENT_LINK"

sudo tee /etc/systemd/system/campusflow-api.service >/dev/null <<SERVICE
# Signature: dev.tswicolly03
[Unit]
Description=CampusFlow API
After=network-online.target docker.service
Wants=network-online.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/opt/campusflow/backend/current
EnvironmentFile=/opt/campusflow/backend/.env
ExecStart=/usr/bin/node dist/server.js
Restart=always
RestartSec=5
NoNewPrivileges=true
PrivateTmp=true

[Install]
WantedBy=multi-user.target
SERVICE

sudo systemctl daemon-reload
sudo systemctl enable campusflow-api >/dev/null
sudo systemctl restart campusflow-api

sudo tee /etc/systemd/system/campusflow-firewall.service >/dev/null <<FIREWALL
# Signature: dev.tswicolly03
[Unit]
Description=CampusFlow firewall rules for Caddy HTTP/HTTPS
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/sh -c '/usr/sbin/iptables -C INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT 2>/dev/null || /usr/sbin/iptables -I INPUT 6 -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT'
ExecStart=/bin/sh -c '/usr/sbin/iptables -C INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT 2>/dev/null || /usr/sbin/iptables -I INPUT 6 -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT'

[Install]
WantedBy=multi-user.target
FIREWALL

sudo systemctl daemon-reload
sudo systemctl enable --now campusflow-firewall >/dev/null

if [ -f /etc/caddy/Caddyfile ]; then
  sudo cp /etc/caddy/Caddyfile "/etc/caddy/Caddyfile.backup.$(date +%Y%m%d%H%M%S)"
  sudo tee /etc/caddy/Caddyfile >/dev/null <<CADDY
# Signature: dev.tswicolly03
tswicolly03.duckdns.org {
    handle_path /api/* {
        reverse_proxy 127.0.0.1:3333
    }

    handle {
        reverse_proxy localhost:5006
    }
}
CADDY
  sudo caddy validate --config /etc/caddy/Caddyfile
  sudo systemctl reload caddy
fi

for i in $(seq 1 30); do
  if curl -fsS "http://127.0.0.1:$API_PORT/health" >/dev/null; then
    break
  fi
  sleep 1
  if [ "$i" = "30" ]; then
    echo "API nao respondeu ao healthcheck local a tempo." >&2
    exit 1
  fi
done
echo "CampusFlow API publicada em https://$DOMAIN/api"
echo "Se a URL publica nao abrir, libere as portas TCP 80 e 443 no firewall externo da Oracle Cloud/roteador."
'@

$remoteScript = $remoteScript.Replace("__REMOTE_ARCHIVE__", $remoteArchive)
Set-Content -LiteralPath $localScriptPath -Value $remoteScript -Encoding ASCII

Write-Host "Enviando arquivos para $remote..."
& scp -i $SshKey $archivePath "${remote}:$remoteArchive"
Assert-LastCommand "enviar pacote"
& scp -i $SshKey $localScriptPath "${remote}:$remoteScriptPath"
Assert-LastCommand "enviar script remoto"

Write-Host "Executando deploy remoto..."
& ssh -i $SshKey $remote "bash $remoteScriptPath"
Assert-LastCommand "executar deploy remoto"

Remove-Item -LiteralPath $archivePath -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $localScriptPath -Force -ErrorAction SilentlyContinue

Write-Host "Deploy concluido. Teste: https://$HostName/api/health"
