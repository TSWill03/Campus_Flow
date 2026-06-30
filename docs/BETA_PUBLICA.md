<!-- Signature: dev.tswicolly03 -->

# CampusFlow - Beta Publica

## Objetivo

Preparar uma beta publica utilizavel do CampusFlow sem abandonar a proposta
offline-first. O app deve continuar funcionando sem backend, mas quando houver
endpoint configurado ele pode usar autenticacao remota, sincronizacao inicial,
reports de erro, feedback manual e healthchecks de producao.

## Funcionalidades liberadas

- App Flutter com banco local Drift e backup JSON.
- Login local/offline quando o endpoint da API estiver vazio.
- Login remoto por email/senha quando `CAMPUSFLOW_API_BASE_URL` ou o endpoint
  salvo em Ajustes apontar para a API.
- Google Sign-In quando os Client IDs estiverem configurados.
- Sync generica inicial por `/sync/push` e `/sync/pull`.
- Upload/listagem/download/exclusao logica de anexos autenticados.
- Captura global de erros Flutter com fila local de reenvio.
- Tela `Ajustes > Reportar erro ou feedback`.
- Admin API para listar e triar reports.

## Limitacoes conhecidas

- `/sync/pull` ainda nao aplica automaticamente os dados baixados no Drift.
- Resolucao visual de conflitos ainda nao existe.
- Recuperacao de senha remota gera token de desenvolvimento quando nao esta em
  producao; falta integrar envio real de email.
- Storage local de anexos exige volume persistente em producao.
- Reports sao sanitizados, mas devem ser revisados como dados operacionais
  sensiveis.
- Pagamentos, planos e limites por usuario ainda nao existem.

## Rodar backend local

```powershell
cd backend
npm install
Copy-Item .env.example .env
docker compose up -d postgres
npm run db:generate
npm run db:push
npm run dev
```

Validar:

```powershell
Invoke-RestMethod http://localhost:3333/health
Invoke-RestMethod http://localhost:3333/ready
```

## Rodar app apontando para backend

Padrao de desenvolvimento:

```powershell
flutter pub get
flutter run -d chrome --dart-define=CAMPUSFLOW_API_BASE_URL=http://localhost:3333
```

Build web para um backend publicado:

```powershell
flutter build web --release --dart-define=CAMPUSFLOW_API_BASE_URL=https://api.seudominio.com
```

O usuario tambem pode alterar o endpoint em `Ajustes > Servidor e
sincronizacao`. Deixar o endpoint vazio ativa o modo local/offline.

## Variaveis de ambiente

Backend:

```text
NODE_ENV=production
PORT=3333
DATABASE_URL=postgresql://...
JWT_SECRET=<segredo-longo-aleatorio>
ACCESS_TOKEN_TTL_SECONDS=900
REFRESH_TOKEN_DAYS=30
CORS_ORIGIN=https://app.seudominio.com
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_IDS=
STORAGE_DIR=/opt/campusflow/backend/storage/uploads
ADMIN_API_TOKEN=<token-admin-longo-aleatorio>
```

Flutter build:

```text
CAMPUSFLOW_API_BASE_URL=https://api.seudominio.com
CAMPUSFLOW_APP_VERSION=1.0.0
CAMPUSFLOW_BUILD_NUMBER=1
GOOGLE_WEB_CLIENT_ID=
GOOGLE_SERVER_CLIENT_ID=
GOOGLE_IOS_CLIENT_ID=
```

Regras de producao:

- Nao usar `CORS_ORIGIN=*`.
- `JWT_SECRET` deve ser longo, aleatorio e diferente dos exemplos.
- `ADMIN_API_TOKEN` deve ficar apenas no servidor/operacao.
- Nunca versionar `.env`, chaves, tokens, banco local, uploads ou dumps.

## Checklist antes de publicar

- `npm install` ou `npm ci`.
- `npm run build`.
- `npm test`.
- `npm run db:generate`.
- Aplicar schema no ambiente de producao de forma controlada.
- `flutter pub get`.
- `flutter analyze`.
- `flutter test`.
- `flutter build web --release --dart-define=CAMPUSFLOW_API_BASE_URL=<api>`.
- Verificar `GET /health` e `GET /ready` no dominio publico.
- Validar CORS com o dominio real do frontend.
- Criar conta teste, login, refresh e logout.
- Enviar feedback manual e consultar no admin.
- Confirmar volume persistente para `STORAGE_DIR`.
- Confirmar backup do PostgreSQL.

## Checklist de rollback

- Manter build anterior do Flutter Web disponivel.
- Manter imagem/artefato anterior do backend.
- Antes de mudanca destrutiva, gerar `pg_dump`.
- Se `/ready` falhar, remover o backend novo do proxy e voltar ao processo
  anterior.
- Se reports crescerem demais, ativar rate limit mais restritivo e revisar
  origem do trafego.
- Se sync gerar conflitos inesperados, orientar usuarios a limpar endpoint e
  continuar local/offline ate a correcao.

## Consultar relatorios de erro

Enviar feedback manual no app:

```text
Ajustes > Reportar erro ou feedback
```

Listar reports recentes:

```powershell
$headers = @{ "x-admin-token" = $env:CAMPUSFLOW_ADMIN_API_TOKEN }
Invoke-RestMethod "https://api.seudominio.com/admin/error-reports?limit=50" -Headers $headers
```

Filtrar:

```powershell
Invoke-RestMethod "https://api.seudominio.com/admin/error-reports?status=open&severity=high&type=crash" -Headers $headers
```

Atualizar status:

```powershell
$body = @{ status = "triaged" } | ConvertTo-Json
Invoke-RestMethod "https://api.seudominio.com/admin/error-reports/<reportId>/status" `
  -Method Patch `
  -Headers ($headers + @{ "Content-Type" = "application/json" }) `
  -Body $body
```

Estados permitidos:

- `open`
- `triaged`
- `resolved`
- `ignored`

## Backup PostgreSQL

Docker local/VPS:

```bash
sudo docker exec campusflow-postgres pg_dump -U campus_flow campus_flow > campusflow_backup_$(date +%Y%m%d_%H%M).sql
```

Restaurar:

```bash
cat campusflow_backup_YYYYMMDD_HHMM.sql | sudo docker exec -i campusflow-postgres psql -U campus_flow campus_flow
```

## Observabilidade segura

- Toda resposta de erro inclui `requestId`.
- Erros internos em producao retornam mensagem generica.
- Logs de erro usam metodo, rota, requestId, userId quando existir, status code
  e tipo do erro.
- Nao registrar Authorization, refresh token, senha, payload completo de sync,
  PDFs, anexos ou banco local.
- Reports de Flutter usam dados tecnicos basicos e passam por sanitizacao.
