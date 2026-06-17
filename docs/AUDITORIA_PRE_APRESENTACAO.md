<!-- Signature: dev.tswicolly03 -->

# Auditoria pre-apresentacao

Data: 2026-06-17

## Diagnostico geral

O CampusFlow esta demonstravel, mas a apresentacao deve separar bem o que ja e
produto funcional offline-first e o que ainda e fundacao para evolucao online.
O app salva dados localmente com Drift, possui login local/remoto, backup JSON,
anexos locais e backend Fastify/PostgreSQL. A sincronizacao remota existe como
fila e API generica, mas ainda nao deve ser apresentada como multi-dispositivo
completo.

## Classificacao dos principais achados

- Confirmado no codigo: `ApiSettingsController` ignorava a URL salva e sempre
  voltava para a default do build.
- Confirmado no codigo: `ApiClient` nao tinha timeout/captura amigavel para
  servidor indisponivel, URL invalida ou proxy retornando HTML.
- Confirmado no codigo: o backend tinha `/health`, mas nao tinha `/ready`
  validando PostgreSQL e storage.
- Confirmado no codigo: erro 500 em producao podia devolver detalhe interno.
- Confirmado no codigo: o backend nao retorna `devResetToken` em producao e
  revoga refresh tokens ao redefinir senha.
- Confirmado no codigo: refresh tokens sao salvos apenas como hash.
- Confirmado no codigo: upload remoto tem limite de tamanho/quantidade pelo
  Fastify multipart, mas usa buffer em memoria e ainda e uma fundacao para
  evolucao, nao storage final de escala.
- Confirmado no codigo: `/sync/pull` baixa mudancas e atualiza cursor, mas o
  Flutter ainda nao aplica essas mudancas no banco local.
- Suspeita monitorada: se o endpoint publico cair, login remoto falha; o app
  agora exibe mensagem amigavel e permite cair para modo local/offline em
  Ajustes.
- Melhoria futura: rate limit em rotas de auth, envio real de email e storage
  externo para anexos.

## Correcoes feitas nesta rodada

- `ApiSettingsController` agora le endpoint salvo em `SharedPreferences`, usa a
  URL de build quando nao existe valor salvo, normaliza barras finais e permite
  endpoint vazio intencional para modo local/offline.
- Tela de Ajustes agora mostra endpoint ativo, salva/restaura endpoint, testa
  conexao com `/health` e permite limpar o endpoint para plano B offline.
- Tela de login agora tambem permite ativar modo local/offline antes de entrar,
  cobrindo o caso de servidor remoto indisponivel na primeira abertura.
- `ApiClient` agora tem timeout padrao de 12 segundos e mensagens amigaveis para
  servidor fora, URL invalida e resposta HTML/proxy.
- Backend agora tem `GET /ready` verificando Prisma/PostgreSQL e `STORAGE_DIR`.
- Backend agora devolve erro 500 generico em `NODE_ENV=production`.
- Backend agora bloqueia `CORS_ORIGIN=*` em producao.
- Adicionados `.nvmrc`, `.env.production.example`, scripts de check e script de
  limpeza de tokens expirados.
- Adicionados testes para API settings, falhas do ApiClient e health/readiness.

## Relatorio arquivo por arquivo

| Area | Arquivo | Erro encontrado | Impacto | Correcao | Prioridade | Status |
| --- | --- | --- | --- | --- | --- | --- |
| Raiz do projeto | `.nvmrc` | Node 22 estava apenas em docs/package | Clone podia usar Node errado | Criado `.nvmrc` com Node 22 | Media | Corrigido |
| Scripts | `scripts/check_all.ps1` | Nao havia check unico de pre-demo | Validacao manual ficava facil de esquecer | Script criado | Media | Corrigido |
| Flutter core | `lib/core/network/api_settings.dart` | URL salva era ignorada | App forcava servidor e impedia fallback local claro | Le/salva URL real, normaliza e aceita vazio | Critica | Corrigido |
| Flutter core | `lib/core/network/api_client.dart` | Sem timeout/captura de rede | Demo podia mostrar erro tecnico cru | Timeout e mensagens amigaveis | Alta | Corrigido |
| Flutter auth | `lib/features/auth/data/repositories/hybrid_auth_repository.dart` | Modo remoto depende de `hasServer` | Com URL sempre default, local ficava inacessivel | Corrigido na origem da configuracao | Alta | Corrigido |
| Flutter sync | `lib/core/sync/remote_sync_service.dart` | Pull nao aplica mudancas no banco local | Sync nao e multi-dispositivo completa | Documentado como parcial | Alta | Documentado |
| Flutter sync | `lib/core/sync/remote_sync_service.dart` | Push nao envia `baseVersion` real do servidor | Conflito ainda e fundacao | Documentado como pendente | Media | Documentado |
| Flutter backup/importacao | `lib/core/backup/backup_service.dart` | Import e destrutivo, mas com validacao/restore point | Risco controlado | Manter fluxo e demonstrar restore point | Media | OK |
| Flutter anexos | `lib/core/attachments/*` | App usa anexos locais; upload remoto ainda nao integrado | Nao prometer nuvem de anexos completa | Documentado | Media | Documentado |
| Flutter UI/demo | `lib/features/settings/presentation/pages/settings_page.dart` | Ajustes nao testava API nem configurava endpoint | Dificultava plano B | UI de endpoint/teste/clear adicionada | Alta | Corrigido |
| Flutter UI/demo | `lib/features/auth/presentation/pages/login_page.dart` | Fallback local ficava atras do login | Servidor fora podia bloquear entrada | Controle offline/local no login | Alta | Corrigido |
| Backend config | `backend/.env.example` | Dev env existia; faltava exemplo prod separado | Risco de misturar dev/prod | Criado `.env.production.example` | Media | Corrigido |
| Backend config | `backend/src/config/env.ts` | CORS `*` possivel em producao | Superficie aberta indevida | Bloqueio em producao | Alta | Corrigido |
| Backend app | `backend/src/app.ts` | Faltava `/ready` | `/health` nao provava DB | Criado `/ready` com DB/storage | Alta | Corrigido |
| Backend auth | `backend/src/modules/auth/auth.service.ts` | Sem envio real de email | Reset completo depende de provedor futuro | Documentado como pendente | Media | Documentado |
| Backend auth | `backend/scripts/cleanup-expired-tokens.ts` | Sem limpeza manual simples de tokens | Tokens expirados poderiam acumular | Script seguro adicionado | Baixa | Corrigido |
| Backend sync | `backend/src/modules/sync/*` | Sync aceita payload generico, mas resolucao visual nao existe | Nao vender como sync final | Documentado | Alta | Documentado |
| Backend files | `backend/src/modules/files/file.routes.ts` | Upload usa buffer em memoria | Arquivo grande pode pressionar RAM | Limite de 25 MB mantido e risco documentado | Media | Documentado |
| Backend Prisma/PostgreSQL | `backend/prisma/schema.prisma` | Schema atende MVP; migrations formais ainda futuras | `db push` e bom para demo, nao producao final | Documentado | Media | Documentado |
| Docs | `docs/PLANO_B_DEMO.md` | Plano B estava espalhado | Falha ao vivo podia gerar improviso | Documento criado | Alta | Corrigido |
| CI | `.github/workflows/ci.yml` | CI ainda nao existe | Garantia depende de check local | Documentado como proximo passo | Media | Pendente |
| Seguranca | `backend/src/shared/http.ts` | 500 devolvia detalhe interno | Vazamento de erro interno em producao | Mensagem generica em prod | Alta | Corrigido |

## Checklists rapidos

## Validacao executada nesta rodada

```powershell
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
cd backend
npm run build
npm test
cd ..
flutter build web --release
flutter build windows --release
Invoke-RestMethod https://tswicolly03.duckdns.org/api/health
Invoke-RestMethod https://tswicolly03.duckdns.org/api/ready
```

Resultado:

- `build_runner`: OK.
- `flutter analyze`: sem issues.
- `flutter test`: 39 testes passando.
- `npm run build`: OK.
- `npm test`: 5 arquivos, 10 testes passando.
- `flutter build web --release`: OK.
- `flutter build windows --release`: OK.
- `https://tswicolly03.duckdns.org/api/health`: respondeu `200`.
- `https://tswicolly03.duckdns.org/api/ready`: respondeu `404` no servidor
  publico atual, porque a nova rota ainda precisa de deploy.

### Clone e run

1. Instalar Flutter stable e Node 22.
2. Rodar `flutter pub get`.
3. Rodar `flutter pub run build_runner build --delete-conflicting-outputs`.
4. Rodar `flutter run -d windows` ou `flutter run -d chrome`.

### Backend e banco

1. `cd backend`.
2. `npm install`.
3. `Copy-Item .env.example .env`.
4. `docker compose up -d postgres`.
5. `npm run db:push`.
6. `npm run dev`.
7. Testar `http://localhost:3333/health`.
8. Testar `http://localhost:3333/ready`.

### API

- `/health`: processo vivo.
- `/ready`: processo + PostgreSQL + storage.
- `/auth/*`: login, registro, Google, refresh e reset.
- `/sync/*`: envio e pull basico de mudancas.
- `/files/*`: fundacao para arquivos remotos.

### FrontEnd

- Login remoto depende de endpoint configurado.
- Modo local/offline fica disponivel quando o endpoint e limpo no login ou em
  Ajustes.
- Ajustes mostra endpoint ativo e permite testar conexao.
- Backup JSON funciona sem backend.

### Sincronizacao

- Implementado: fila local, push para API, marcacao de accepted/failed,
  atualizacao de `remoteId` e leitura de pull.
- Parcial: pull ainda nao aplica mudancas no banco local.
- Pendente: `baseVersion` real de servidor e tela de resolucao de conflitos.

### Seguranca

- Senhas locais/remotas nao ficam em texto puro.
- Refresh token remoto fica hashado.
- Erro 500 em producao e generico.
- CORS `*` e bloqueado em producao.
- Pendente: rate limit, email real, monitoramento e storage externo.

## Plano de fala honesto

Use esta frase se perguntarem sobre sincronizacao:

> "A sincronizacao ja tem a fundacao: fila local, endpoint de push/pull e
> metadados de entidade. O que ainda esta parcial e aplicar automaticamente no
> banco local tudo que vem do pull e resolver conflitos visualmente."

Use esta frase se perguntarem sobre anexos remotos:

> "O app ja trabalha bem com anexos locais. O backend ja tem endpoints de
> arquivo, mas a integracao de upload/download remoto ainda e uma etapa futura."

Use esta frase se perguntarem sobre producao:

> "Para demo e acesso controlado, o projeto esta funcional. Para vender, eu
> ainda colocaria CI, rate limit, backup automatico, monitoramento, storage
> externo e migrations formais."

## Riscos restantes

- Servidor publico pode cair; use modo local/offline e backup JSON como plano B.
- O codigo local tem `/ready`, mas o servidor publico so passara a responder
  essa rota depois de um novo deploy do backend.
- Google OAuth depende de Client IDs corretos e nao deve ser a unica rota de
  demonstracao.
- iOS precisa ser validado em macOS.
- Docker Compose atual e de desenvolvimento/demo, nao uma arquitetura final de
  producao.
- Sync remota ainda e parcial, como descrito acima.

## Proximos passos pos-apresentacao

1. Criar GitHub Actions para Flutter analyze/test e backend build/test.
2. Implementar rate limit em auth.
3. Enviar email real no reset de senha.
4. Aplicar pull remoto no Drift local com politica de conflitos.
5. Persistir `entityVersion`/`baseVersion` real do servidor no app.
6. Integrar anexos locais com upload/download remoto.
7. Criar migrations Prisma formais para producao.
