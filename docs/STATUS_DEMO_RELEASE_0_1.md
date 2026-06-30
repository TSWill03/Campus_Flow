<!-- Signature: dev.tswicolly03 -->

# Status Demo Release 0.1

Validado em 2026-06-20, Windows 11 Pro, branch `demo-release-0.1`.

## Implementado

- Flutter Web abre no Chrome.
- Login local/offline.
- Login e cadastro remotos via API.
- Dashboard, perfil academico, disciplinas, horas complementares e estudos.
- Backup/importacao local.
- Backend Fastify com auth, refresh token, files e sync generica.
- PostgreSQL local via Docker Compose.
- `/health` e `/ready`.

## Corrigido nesta release

- Handler HTTP do backend preserva erros Fastify 4xx; JSON invalido agora retorna
  400 em vez de 500.
- Dependencias transitivas criticas/altas do backend foram atualizadas via
  `npm audit fix`.
- Seed local de demonstracao criado para backend/PostgreSQL.
- Documentacao especifica da Demo Release 0.1 criada.

## Funcionando na demo

- `flutter pub get`.
- `flutter pub run build_runner build --delete-conflicting-outputs`.
- `flutter analyze`.
- `flutter test`.
- `flutter build web --release`.
- `flutter build web --release --dart-define=CAMPUSFLOW_API_BASE_URL=http://localhost:3333`.
- `npm install`.
- `docker compose up -d postgres`.
- `npm run db:generate`.
- `npm run db:push`.
- `npm run build`.
- `npm test`.
- `npm run dev`.
- `GET /health`.
- `GET /ready`.
- `POST /auth/register`.
- `POST /auth/login`.
- `POST /auth/refresh`.
- Flutter Web criando conta remota e abrindo `#/dashboard`.

## Parcial

- Sync remota e base generica validada por API/testes, mas ainda nao e uma
  experiencia completa de sincronizacao multi-dispositivo.
- Google Login depende de configuracao OAuth externa.
- Seed do backend nao popula automaticamente o banco local do Flutter.

## Documentado

- Dados demo.
- Roteiro de apresentacao.
- Checklist final.
- Planos B para API, banco e Flutter Web.
- Scripts auxiliares de demo.

## Pendente

- E2E automatizado permanente para Flutter Web.
- Seed/import visual local para preencher o dashboard sem cadastro manual.
- Tratamento mais completo de conflitos de sync.
- Revisao da vulnerabilidade baixa restante em `esbuild` quando houver versao
  compativel nas ferramentas de desenvolvimento.

## Risco restante

- Flutter Web mostra avisos de dry-run para WebAssembly por dependencias que usam
  `dart:html`; o build JavaScript normal passou.
- `npm audit` ainda aponta uma vulnerabilidade baixa em `esbuild`, transitiva de
  tooling de desenvolvimento no Windows.
- Se Docker Desktop nao estiver aberto, Postgres e `/ready` falham.

## Proximos passos

1. Criar backup local de demo importavel pelo app.
2. Automatizar fluxo visual com Playwright ou integration_test.
3. Evoluir sync para aplicar pull no banco local.
4. Preparar deploy de preview apenas se a banca exigir acesso remoto.
