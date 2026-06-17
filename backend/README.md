<!-- Signature: dev.tswicolly03 -->

# CampusFlow Backend

Backend inicial do CampusFlow para transformar o app offline-first em produto sincronizavel.

## Stack

- Node.js 22+
- Fastify
- Prisma
- PostgreSQL
- JWT com access token e refresh token
- Upload multipart para anexos
- Docker Compose para banco local

## O que esta implementado

- `GET /health`
- `GET /ready`
- `POST /auth/register`
- `POST /auth/login`
- `POST /auth/google`
- `POST /auth/refresh`
- `POST /auth/logout`
- `POST /auth/password/forgot`
- `POST /auth/password/reset`
- `GET /auth/me`
- `POST /sync/push`
- `GET /sync/pull`
- `POST /files/upload`
- `GET /files`
- `GET /files/:id/download`
- `DELETE /files/:id`

## Rodar localmente

```powershell
cd backend
npm install
Copy-Item .env.example .env
docker compose up -d postgres
npm run db:push
npm run dev
```

A API fica em:

```text
http://localhost:3333
```

Healthcheck:

```powershell
Invoke-RestMethod http://localhost:3333/health
Invoke-RestMethod http://localhost:3333/ready
```

`/health` valida apenas que o processo da API esta vivo. `/ready` valida API,
PostgreSQL/Prisma e a pasta de storage configurada em `STORAGE_DIR`.

## Variaveis de ambiente

```text
DATABASE_URL=postgresql://campus_flow:campus_flow@localhost:5432/campus_flow?schema=public
JWT_SECRET=use-um-segredo-longo-e-aleatorio
ACCESS_TOKEN_TTL_SECONDS=900
REFRESH_TOKEN_DAYS=30
CORS_ORIGIN=https://tswicolly03.duckdns.org,http://localhost:*,http://127.0.0.1:*,http://[::1]:*
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_IDS=
STORAGE_DIR=storage/uploads
```

`GOOGLE_CLIENT_ID` deve receber o Client ID Web principal do Google. Se voce tiver IDs extras, por exemplo iOS, coloque-os separados por virgula em `GOOGLE_CLIENT_IDS`.

Use `.env.example` para desenvolvimento/demo local. Para producao, copie
`.env.production.example` e substitua todos os valores `CHANGE_ME`. Em producao,
`CORS_ORIGIN=*` e rejeitado de proposito.

## Sincronizacao

O backend usa uma estrategia generica de sync. O app Flutter pode enviar qualquer entidade local como payload JSON:

```json
{
  "clientId": "device-123",
  "deviceName": "Notebook",
  "changes": [
    {
      "entityType": "academic_profile",
      "localId": "local-profile-id",
      "baseVersion": 1,
      "isDeleted": false,
      "payload": {
        "courseName": "Ciencia da Computacao",
        "totalHours": 3200
      }
    }
  ]
}
```

Resposta esperada:

```json
{
  "serverTime": "2026-04-26T00:00:00.000Z",
  "results": [
    {
      "status": "accepted",
      "entityType": "academic_profile",
      "localId": "local-profile-id",
      "remoteId": "server-id",
      "version": 2,
      "updatedAt": "2026-04-26T00:00:00.000Z"
    }
  ]
}
```

Se o cliente tentar salvar sobre uma versao antiga, o servidor responde `status: "conflict"` com o payload atual do servidor.

Estado atual honesto da sync:

- Implementado: autenticacao, fila local no Flutter, `POST /sync/push`,
  `GET /sync/pull`, `remoteId` e `syncStatus` apos aceite do push.
- Parcial: o Flutter ainda nao aplica automaticamente no banco local as
  mudancas vindas de `/sync/pull`.
- Pendente: `baseVersion` real de servidor no cliente e tela de resolucao de
  conflitos.

## Anexos

O upload atual salva arquivos no disco local do servidor. Para producao, use um volume persistente em VPS ou troque essa camada por S3, Cloudflare R2, Backblaze B2 ou outro storage compativel.

O limite atual do multipart e de ate 8 arquivos por requisicao e 25 MB por
arquivo. A rota `POST /files/upload` salva um arquivo por chamada no modelo
atual. Para escala, troque o buffer em memoria por streaming direto para storage.

Campos multipart esperados em `POST /files/upload`:

- `file`
- `entityType`
- `entityId`
- `category` opcional

## Scripts uteis

Na raiz do repositorio:

```powershell
.\scripts\check_all.ps1
```

Somente backend:

```powershell
cd backend
.\scripts\check_backend.ps1
npm run tokens:cleanup
```

`tokens:cleanup` remove refresh tokens expirados e tokens de reset expirados ou
ja usados. Ele nao remove usuarios.

## Deploy

### Web do Flutter

O Flutter Web e estatico. Pode ir para Netlify, Vercel, Cloudflare Pages ou outro host estatico.

```powershell
flutter build web --release
netlify deploy --prod --dir=build/web
```

Para apontar o app para o backend publicado:

```powershell
flutter build web --release --dart-define=CAMPUSFLOW_API_BASE_URL=https://api.seudominio.com
flutter build windows --release --dart-define=CAMPUSFLOW_API_BASE_URL=https://api.seudominio.com
```

### Backend

Este backend e uma API Node longa, entao ele deve rodar em um ambiente que aceite processo persistente:

- Render
- Railway
- Fly.io
- VPS com Docker
- servidor proprio em casa com HTTPS, proxy reverso e backup

Netlify e melhor para hospedar o frontend. Para o backend, use Netlify Functions apenas se futuramente a API for adaptada para serverless.

### Servidor em casa

Funciona para laboratorio ou um primeiro piloto. Para vender, cuide de:

- dominio e HTTPS
- proxy reverso com Caddy, Nginx ou Traefik
- backup automatico do Postgres
- monitoramento e logs
- atualizacoes de seguranca
- IP fixo ou DDNS
- armazenamento persistente dos anexos

Exemplo de caminho para o servidor de Vinhedo:

1. Subir este backend com Docker ou Node em um processo persistente.
2. Rodar PostgreSQL no proprio servidor ou em banco gerenciado.
3. Colocar Caddy/Nginx/Traefik na frente da API.
4. Emitir HTTPS para um dominio, por exemplo `api.seudominio.com`.
5. Definir `CORS_ORIGIN` com o dominio do Flutter Web.
6. Compilar o Flutter com `CAMPUSFLOW_API_BASE_URL=https://api.seudominio.com`.

### Deploy configurado para Vinhedo

Este projeto ja possui um deploy guiado para:

```text
https://tswicolly03.duckdns.org/api
```

Pelo Windows, rode na raiz do projeto:

```powershell
$env:CAMPUSFLOW_SSH_KEY = "<caminho-da-sua-chave-ssh>"
.\backend\deploy\vinhedo\deploy.ps1
```

O script usa:

- SSH: `ubuntu@tswicolly03.duckdns.org`
- chave: valor local de `CAMPUSFLOW_SSH_KEY` ou parametro `-SshKey`
- API Node em `127.0.0.1:3333`
- PostgreSQL Docker em `127.0.0.1:5433`
- firewall local liberando `80` e `443` via `campusflow-firewall`
- Caddy expondo a API publica em `/api`

Configurar Google OAuth no servidor:

```powershell
.\backend\deploy\vinhedo\set-google-oauth.ps1 `
  -WebClientId "SEU_WEB_CLIENT_ID.apps.googleusercontent.com"
```

Se houver Client IDs extras:

```powershell
.\backend\deploy\vinhedo\set-google-oauth.ps1 `
  -WebClientId "SEU_WEB_CLIENT_ID.apps.googleusercontent.com" `
  -ExtraClientIds "SEU_IOS_CLIENT_ID.apps.googleusercontent.com,OUTRO_CLIENT_ID.apps.googleusercontent.com"
```

Depois do deploy, teste:

```text
https://tswicolly03.duckdns.org/api/health
https://tswicolly03.duckdns.org/api/ready
```

No servidor, os comandos mais importantes sao:

```bash
sudo systemctl status campusflow-api
sudo journalctl -u campusflow-api -f
sudo systemctl restart campusflow-api
```

Backup manual do banco:

```bash
sudo docker exec campusflow-postgres pg_dump -U campus_flow campus_flow > campusflow_backup_$(date +%Y%m%d).sql
```

Restauracao manual de um backup SQL:

```bash
cat campusflow_backup_YYYYMMDD.sql | sudo docker exec -i campusflow-postgres psql -U campus_flow campus_flow
```

O arquivo `/opt/campusflow/backend/.env` contem segredos de producao. Ele deve ficar apenas no servidor.

Se `curl http://127.0.0.1:3333/health` funcionar no servidor, mas `https://tswicolly03.duckdns.org/api/health` nao abrir fora dele, o problema nao esta na API: libere as portas `80` e `443` no firewall externo da Oracle Cloud, no NSG/Security List ou no roteador que aponta para esse servidor.

Passo rapido na Oracle Cloud:

1. `Networking > Virtual Cloud Networks`.
2. Abra a VCN e a subnet da VM.
3. Em `Security Lists` ou `Network Security Groups`, adicione duas regras de entrada TCP.
4. Use `Source CIDR = 0.0.0.0/0`.
5. Use `Destination Port Range = 80` na primeira regra.
6. Use `Destination Port Range = 443` na segunda regra.
7. Teste `https://tswicolly03.duckdns.org/api/health`.
8. Teste `https://tswicolly03.duckdns.org/api/ready`.

## Proximos passos

- Integrar o Flutter com `/auth/*` e substituir o login local por login remoto quando o usuario ativar sync.
- Mapear a fila local `sync_queue` do app para `/sync/push`.
- Atualizar `remoteId`, `syncStatus` e `entityVersion` no app apos resposta do servidor.
- Trocar storage local por S3/R2 antes de vender em escala.
- Adicionar envio real de email para recuperacao de senha.
- Criar planos/pagamentos com Stripe, Mercado Pago, Paddle ou loja da Microsoft.
