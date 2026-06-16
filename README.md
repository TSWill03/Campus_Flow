<!-- Signature: dev.tswicolly03 -->

# CampusFlow

CampusFlow e um gerenciador academico pessoal offline-first para estudantes universitarios. O app centraliza perfil academico, disciplinas, horas obrigatorias, organizacao de estudos e backup local em JSON, sem depender de backend no MVP.

## Para apresentacao academica

Este repositorio tambem esta preparado para ser apresentado como projeto final,
TCC ou trabalho de disciplina. A documentacao de apoio fica em:

- `docs/GUIA_DE_APRESENTACAO.md`: narrativa do projeto, problema, solucao,
  decisoes tecnicas e perguntas provaveis da banca.
- `docs/MAPA_DO_CODIGO.md`: caminho de leitura para explicar o codigo sem se
  perder na estrutura.
- `docs/ROTEIRO_DE_DEMO.md`: ordem sugerida para demonstrar o app funcionando.
- `docs/AUDITORIA_RELEASE.md`: checklist tecnico, incongruencias corrigidas,
  testes adicionados e validacao de build.

Sugestao de apresentacao: primeiro mostre o problema do estudante, depois a demo
do app e, por ultimo, abra o codigo para explicar arquitetura, banco local,
sync, importacao de grade e backend.

## Stack

- Flutter stable 3.38.x
- Material 3
- `flutter_riverpod` 2.6.x
- `go_router`
- `drift` + `drift_flutter`
- `freezed` + `json_serializable`
- `intl`
- `uuid`
- `file_picker`
- `shared_preferences`
- `flutter_secure_storage`
- `cryptography`
- `google_sign_in`

### Observacao sobre escolhas

- `Drift` foi escolhido em vez de alternativas como `Isar` porque o dominio academico tem relacoes claras entre entidades, consultas agregadas e potencial futuro de sincronizacao com backend relacional.
- `flutter_riverpod` 2.6.x foi mantido de proposito por compatibilidade madura com o ecossistema atual de `build_runner` no Flutter stable desta base. A arquitetura ja esta pronta para migrar para Riverpod 3 quando a stack do projeto pedir isso.

## Funcionalidades do MVP

- Multiplos perfis academicos com universidade, faculdade/escola, campus e nivel
- Definicao de perfil academico ativo para filtrar dashboard e listas
- Cadastro e acompanhamento de disciplinas
- Historico de aulas por disciplina com conteudo, atividade, prova e PDF
- Horas optativas por disciplina
- Dashboard com indicadores do curso
- Cadastro de atividades complementares
- Cadastro de estagios
- Cadastro de atividades de extensao
- Materias de estudo independentes da grade
- Topicos por materia
- Tarefas de estudo
- Registro e historico de sessoes de estudo
- Exportacao e importacao de backup JSON
- Restore point automatico antes de importacoes destrutivas
- Perfil de cores personalizado do usuario
- Tema claro, escuro e seguir sistema
- Login local seguro com email e senha
- Codigo de recuperacao local para redefinir senha sem backend
- Vinculo opcional com Google quando a plataforma e a configuracao OAuth permitirem
- Login com Google conectado ao backend quando os Client IDs OAuth estao configurados

## Arquitetura

O projeto usa uma Clean Architecture simplificada, organizada por feature e separada em `data`, `domain` e `presentation`.

```text
lib/
  app.dart
  main.dart
  core/
    backup/
    database/
    error/
    router/
    sync/
    theme/
    utils/
  shared/
    enums/
    extensions/
    widgets/
  features/
    academic_profile/
      data/
      domain/
      presentation/
    complementary_hours/
      data/
      domain/
      presentation/
    course_subjects/
      data/
      domain/
      presentation/
    dashboard/
      data/
      domain/
      presentation/
    extension_activities/
      data/
      domain/
      presentation/
    internships/
      data/
      domain/
      presentation/
    settings/
      presentation/
    study_manager/
      data/
      domain/
      presentation/
```

### Como cada camada foi usada

- `domain`: entidades imutaveis com `freezed` e contratos de repositorio
- `data`: implementacoes locais dos repositorios usando Drift
- `presentation`: paginas, formularios, widgets de modulo e providers Riverpod
- `core`: infraestrutura transversal do app
- `shared`: enums, extensoes e widgets reutilizaveis

## Offline-first e persistencia local

Todos os dados do MVP sao persistidos localmente em SQLite via Drift.

## Autenticacao local segura

O app agora possui uma camada de autenticacao local desacoplada do banco academico:

- a senha nao fica em texto puro; ela e derivada com PBKDF2 (`cryptography`) e guardada apenas como hash
- os artefatos de autenticacao e a sessao local ficam em armazenamento seguro do dispositivo com `flutter_secure_storage`
- ao criar a conta, o app gera um codigo de recuperacao local
- o fluxo `Esqueceu sua senha?` redefine a senha com esse codigo ou com a conta Google vinculada, quando disponivel

### Google

O login com Google usa OAuth do Google no app e validacao de `idToken` no backend.

- Web: usa o botao oficial do Google Identity Services.
- Android: usa `GOOGLE_SERVER_CLIENT_ID` com o Client ID Web do Google.
- iOS: usa `GOOGLE_IOS_CLIENT_ID`, `GOOGLE_SERVER_CLIENT_ID` e URL scheme no `Info.plist`.
- Windows/Linux: o botao fica desabilitado nesta etapa; use email e senha.

Para ativar em desenvolvimento Web:

```powershell
flutter run -d chrome --web-hostname localhost --web-port 7357 `
  --dart-define=GOOGLE_WEB_CLIENT_ID=SEU_WEB_CLIENT_ID.apps.googleusercontent.com
```

Para build Web:

```powershell
flutter build web --release `
  --dart-define=GOOGLE_WEB_CLIENT_ID=SEU_WEB_CLIENT_ID.apps.googleusercontent.com
```

Para Android:

```powershell
flutter run -d android `
  --dart-define=GOOGLE_SERVER_CLIENT_ID=SEU_WEB_CLIENT_ID.apps.googleusercontent.com
```

O backend tambem precisa aceitar esse Client ID. No servidor de Vinhedo:

```powershell
.\backend\deploy\vinhedo\set-google-oauth.ps1 `
  -WebClientId "SEU_WEB_CLIENT_ID.apps.googleusercontent.com"
```

No Google Cloud Console, configure:

- OAuth consent screen com nome `CampusFlow`.
- OAuth Client `Web application` com JavaScript origins `http://localhost:7357` e `https://tswicolly03.duckdns.org`.
- OAuth Client `Android` com package `com.campusflow.campus_flow` e SHA-1 do certificado usado no build.
- OAuth Client `iOS` com o bundle id do Runner quando for publicar iOS.

As tabelas foram desenhadas com metadados para sincronizacao futura:

- `id`
- `remoteId`
- `createdAt`
- `updatedAt`
- `syncStatus`
- `isDeleted`

Valores atuais de `syncStatus`:

- `pendingCreate`
- `pendingUpdate`
- `pendingDelete`
- `synced`

No MVP:

- a aplicacao funciona 100% offline
- exclusoes sao feitas por soft delete nas operacoes de dominio
- o dashboard e atualizado por queries agregadas do Drift
- formularios principais usam controllers Riverpod com estado de submissao

## Backup JSON

Como ainda nao existe backend, o app oferece backup local completo:

### Exportacao

- gera um arquivo `.json` com todas as entidades do banco
- inclui `schemaVersion` para compatibilidade futura
- inclui tambem registros marcados para sincronizacao futura
- pode ser salvo manualmente no dispositivo

### Importacao

- seleciona um arquivo `.json`
- valida referencias e versao antes de alterar o banco
- salva um restore point automatico do estado atual antes de substituir dados
- suporta estrutura pronta para `replaceAll` e `merge`
- restaura perfil, disciplinas, horas, materias, topicos, tarefas e sessoes

Fluxo esperado:

1. Exportar backup.
2. Enviar o arquivo por email, nuvem ou outro meio.
3. Importar o mesmo arquivo em outro dispositivo.

## Web

O projeto foi preparado para web com Drift em WASM:

- `web/sqlite3.wasm`
- `web/drift_worker.js`

Esses artefatos ja foram incluidos para a conexao web do Drift. O suporte web foi habilitado na toolchain e a arquitetura do banco ja usa `drift_flutter` com opcoes web configuradas.

## Backend

O repositorio agora inclui uma API inicial em `backend/` para a evolucao SaaS do CampusFlow.

Essa API entrega:

- autenticacao central com email/senha, refresh token e Google via `idToken`
- recuperacao de senha por token
- sincronizacao generica offline-first por entidade
- upload, listagem, download e exclusao logica de anexos
- PostgreSQL via Prisma
- Docker Compose para banco local

Para rodar:

```powershell
cd backend
npm install
Copy-Item .env.example .env
docker compose up -d postgres
npm run db:push
npm run dev
```

Mais detalhes estao em `backend/README.md`.

### Conectar o app ao servidor

O app usa o backend automaticamente quando `CAMPUSFLOW_API_BASE_URL` esta definido no codigo/build.

Para usar seu servidor de Vinhedo, a URL padrao configurada no codigo e:

```text
https://tswicolly03.duckdns.org/api
```

Em `Ajustes > Servidor e sincronizacao`, o app apenas mostra o endpoint ativo e permite acionar uma sincronizacao manual. Nao existe mais toggle para escolher login local ou remoto.

Para outros servidores, publique a API com HTTPS e use algo como:

```text
https://api.seudominio.com
```

Tambem da para embutir uma URL padrao no build:

```powershell
flutter build web --release --dart-define=CAMPUSFLOW_API_BASE_URL=https://api.seudominio.com
flutter build windows --release --dart-define=CAMPUSFLOW_API_BASE_URL=https://api.seudominio.com
```

Para o servidor de Vinhedo:

```powershell
flutter build web --release --dart-define=CAMPUSFLOW_API_BASE_URL=https://tswicolly03.duckdns.org/api
flutter build windows --release --dart-define=CAMPUSFLOW_API_BASE_URL=https://tswicolly03.duckdns.org/api
```

Depois de abrir o app:

- entre ou crie uma conta normalmente
- o login usa o servidor automaticamente
- a sincronizacao roda automaticamente apos carregar uma sessao autenticada
- use `Sincronizar agora` para enviar a fila local para a API
- use `Descartar fila antiga` se estiver migrando dados locais antigos e quiser que apenas novas alteracoes sejam enviadas ao servidor

O modo local continua existindo no codigo como fallback arquitetural, mas nao e mais uma opcao exibida para o usuario.

### Deploy no servidor de Vinhedo

O deploy do backend fica documentado e automatizado em `backend/deploy/vinhedo/`.

Para publicar ou atualizar a API:

```powershell
.\backend\deploy\vinhedo\deploy.ps1
```

O script usa SSH com a chave local informada para acessar `ubuntu@tswicolly03.duckdns.org`, envia o backend, cria o PostgreSQL via Docker, instala a API como servico `campusflow-api` e configura o Caddy para expor `/api`.

Ele tambem cria o servico `campusflow-firewall`, que libera `80` e `443` no firewall local do Linux. Se o teste publico ainda nao abrir, falta liberar essas portas no firewall externo da infraestrutura, como Oracle Cloud Security List/NSG ou redirecionamento do roteador.

No caso da Oracle Cloud, o caminho geral e:

1. Acessar `Networking > Virtual Cloud Networks`.
2. Abrir a VCN/subnet da VM.
3. Entrar em `Security Lists` ou `Network Security Groups`.
4. Criar uma regra TCP com `Source CIDR = 0.0.0.0/0` e porta `80`.
5. Criar outra regra TCP com `Source CIDR = 0.0.0.0/0` e porta `443`.
6. Testar `https://tswicolly03.duckdns.org/api/health`.

Comandos simples para manutencao no servidor:

```powershell
$env:CAMPUSFLOW_SSH_KEY = "<caminho-da-sua-chave-ssh>"
ssh -i "$env:CAMPUSFLOW_SSH_KEY" ubuntu@tswicolly03.duckdns.org
```

```bash
sudo systemctl status campusflow-api
sudo journalctl -u campusflow-api -f
sudo systemctl restart campusflow-api
```

Teste publico:

```text
https://tswicolly03.duckdns.org/api/health
```

Arquivos importantes no servidor:

- codigo atual: `/opt/campusflow/backend/current`
- variaveis secretas: `/opt/campusflow/backend/.env`
- uploads/anexos: `/opt/campusflow/backend/storage/uploads`
- banco PostgreSQL: volume Docker `campusflow_postgres`

Nunca envie a chave SSH nem o arquivo `.env` para o GitHub ou para terceiros.

## Rotas principais

- `/dashboard`
- `/profile`
- `/subjects`
- `/complementary`
- `/internships`
- `/extensions`
- `/study`
- `/settings`

Rotas secundarias incluem formularios e detalhes de topicos.

## Como rodar

### 1. Instalar dependencias

```bash
flutter pub get
```

### 2. Regenerar codigo quando modelos/schema mudarem

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Executar

```bash
flutter run -d windows
```

Ou:

```bash
flutter run -d chrome
flutter run -d android
flutter run -d ios
```

## Validacao feita nesta base

- `flutter pub run build_runner build --delete-conflicting-outputs`
- `flutter analyze`
- `flutter test`
- `flutter build web`

## Ponto de armazenamento local

- banco principal: SQLite gerenciado por Drift
- preferencia de tema: `shared_preferences`
- perfil de cores: `shared_preferences`
- restore point de importacao: `shared_preferences`
- backup manual: arquivo JSON exportado pelo usuario

## Como a base foi preparada para sincronizacao futura

- entidades com metadados de sincronizacao
- `remoteId` reservado em todas as entidades
- `syncStatus` e `isDeleted` prontos para estrategia de fila/outbox
- fila local persistente em `sync_queue_entries` com `entityType`, `entityId`, `entityVersion`, `operation`, `payloadJson`, `deviceId`, `conflictPolicy` e `lastSyncedAt`
- indices e `check constraints` para crescer com mais volume e sincronizacao incremental
- camada `core/sync` ja fornece `deviceId` e visao geral da fila local
- repositorios separados da UI, facilitando troca de datasource local/remoto
- estrutura por feature pronta para login, cache, resolucao de conflitos e multi-dispositivo

## Proximos passos recomendados

1. Adicionar casos de uso explicitos por feature para regras mais complexas.
2. Criar uma estrategia de migracoes do Drift conforme o schema crescer.
3. Implementar sincronizacao incremental com fila local e politicas de conflito.
4. Adicionar autenticacao e vinculacao de conta.
5. Incluir notificacoes locais para tarefas e sessoes planejadas.
6. Cobrir formularios, repositorios e backup com testes automatizados mais amplos.
7. Evoluir design system, acessibilidade e internacionalizacao.

## Publicacao futura

A base evita dependencias experimentais e foi montada pensando em publicacao futura em:

- Google Play Store
- Apple App Store
- Microsoft Store

O app nao depende de backend para funcionar, mas a arquitetura ja permite a evolucao gradual para login, sincronizacao, backup em nuvem e notificacoes.
