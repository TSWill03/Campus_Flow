<!-- Signature: dev.tswicolly03 -->

# Guia tecnico de arquitetura e perguntas

Este arquivo foi feito para servir como apoio rapido na apresentacao do
CampusFlow. A ideia e responder perguntas como:

- Como o app conecta no banco de dados?
- Onde esta a API?
- Como o Flutter faz requisicao para o backend?
- Onde ficam as regras de negocio?
- Como funciona a sincronizacao?
- O que e local e o que e servidor?
- O que ainda falta para producao?

Use este documento como um "mapa de defesa tecnica": se perguntarem alguma
coisa, voce consegue abrir o arquivo certo e explicar o caminho do dado.

## Resumo para falar em 1 minuto

O CampusFlow e um aplicativo Flutter multiplataforma, organizado com uma Clean
Architecture simplificada por features. Ele foi pensado como offline-first: o
usuario consegue usar o app com banco local SQLite via Drift, mesmo sem internet.

Quando existe login e servidor configurado, as alteracoes entram em uma fila
local de sincronizacao e sao enviadas para uma API Node/Fastify. Essa API usa
PostgreSQL por meio do Prisma. O app nunca acessa o PostgreSQL diretamente; ele
sempre passa pela API.

O projeto separa bem as responsabilidades:

- Flutter cuida da interface, estado, banco local e experiencia offline.
- Drift/SQLite guarda os dados locais do dispositivo.
- Riverpod injeta dependencias e controla estados de tela/formulario.
- go_router organiza navegacao e protecao por login.
- Fastify fornece a API de auth, sync e arquivos.
- Prisma conecta o backend ao PostgreSQL.

## Arquitetura em camadas

```text
CampusFlow
  Flutter app
    lib/main.dart
    lib/app.dart
    lib/core
    lib/shared
    lib/features

  Backend
    backend/src/server.ts
    backend/src/app.ts
    backend/src/modules
    backend/prisma/schema.prisma

  Dados
    Local: Drift + SQLite por dispositivo
    Remoto: Fastify API + Prisma + PostgreSQL
```

## Onde comeca o Flutter

Arquivo principal:

```text
lib/main.dart
```

O que ele faz:

- chama `WidgetsFlutterBinding.ensureInitialized()`
- carrega `SharedPreferences`
- cria uma instancia de `AppDatabase`
- sobe o app dentro de `ProviderScope`
- injeta `sharedPreferencesProvider` e `appDatabaseProvider`

Explicacao para banca:

> "Eu centralizo as dependencias principais na inicializacao do app. Assim as
> features recebem banco e preferencias via Riverpod, sem depender de singletons
> soltos. Isso tambem facilita teste, porque consigo substituir essas
> dependencias por versoes em memoria."

## Onde fica o widget raiz

Arquivo:

```text
lib/app.dart
```

Responsabilidades:

- configura `MaterialApp.router`
- aplica tema claro/escuro e perfil de cores
- configura idioma `pt-BR`
- usa `appRouterProvider`
- dispara sincronizacao automatica quando o usuario esta autenticado

Ponto importante:

O app continua funcionando se a sincronizacao falhar. A sincronizacao roda de
forma nao bloqueante; se o servidor cair, a fila local continua existindo.

## Onde ficam as rotas

Arquivo:

```text
lib/core/router/app_router.dart
```

Tecnologia:

```text
go_router
```

O que mostrar:

- `/login`
- `/forgot-password`
- `/dashboard`
- `/profile`
- `/subjects`
- `/subjects/:id`
- `/settings`

Como a protecao funciona:

- se a sessao esta carregando, vai para `/splash`
- se nao esta autenticado, vai para `/login`
- se esta autenticado, entra nas telas internas

Resposta pronta:

> "A navegacao nao fica espalhada nas telas. O arquivo de router centraliza as
> rotas e tambem faz o controle de autenticacao. Isso evita que cada tela tenha
> que decidir sozinha se o usuario pode entrar."

## Como funciona a organizacao por features

Exemplo:

```text
lib/features/course_subjects
  data
  domain
  presentation
```

Camadas:

- `domain`: entidades e contratos, sem depender de Flutter ou banco.
- `data`: implementacao concreta, como repositorios Drift ou API.
- `presentation`: paginas, widgets e controllers Riverpod.

Exemplo real de disciplina:

```text
lib/features/course_subjects/domain/entities/course_subject.dart
lib/features/course_subjects/domain/repositories/course_subject_repository.dart
lib/features/course_subjects/data/repositories/drift_course_subject_repository.dart
lib/features/course_subjects/presentation/providers/course_subject_form_controller.dart
lib/features/course_subjects/presentation/pages/course_subject_form_page.dart
```

Resposta pronta:

> "A tela nao precisa saber como o banco funciona. Ela chama um controller, o
> controller monta a entidade e chama um repositorio. A implementacao atual desse
> repositorio usa Drift, mas a tela nao fica presa a isso."

## Como conecta no banco local

Arquivo principal:

```text
lib/core/database/app_database.dart
```

Provider do banco:

```text
lib/core/database/database_providers.dart
```

Tecnologia:

```text
Drift + SQLite
```

Como o banco e criado:

```dart
AppDatabase()
```

Dentro de `AppDatabase`, o Drift usa:

```dart
driftDatabase(
  name: 'campus_flow',
  web: DriftWebOptions(
    sqlite3Wasm: Uri.parse('sqlite3.wasm'),
    driftWorker: Uri.parse('drift_worker.js'),
  ),
)
```

Explicacao:

- no Android, iOS e Windows, o Drift usa SQLite local do dispositivo
- na Web, o Drift usa SQLite via WASM com suporte do navegador
- o banco local se chama `campus_flow`
- cada instalacao tem seu proprio banco local
- o app nao precisa de internet para salvar dados

Pergunta provavel: "Web, Windows, Android e iOS usam o mesmo banco?"

Resposta:

> "Eles usam o mesmo schema e o mesmo codigo Dart, mas nao o mesmo arquivo de
> banco. Cada plataforma/dispositivo tem sua propria base local. Para compartilhar
> dados entre dispositivos, entra a sincronizacao com o backend."

## Tabelas principais do banco local

As tabelas ficam em:

```text
lib/core/database/app_database.dart
```

Principais tabelas:

- `AcademicProfiles`: perfis academicos, curso, instituicao e horas obrigatorias
- `CourseSubjects`: disciplinas, status, pre-requisitos, ementa e horarios
- `CourseSubjectLessons`: aulas de cada disciplina
- `Attachments`: anexos locais ligados a aula, atividade complementar ou estagio
- `ComplementaryActivities`: horas complementares
- `Internships`: estagios
- `ExtensionActivities`: atividades de extensao
- `StudySubjects`: materias de estudo
- `StudyTopics`: topicos
- `StudyTasks`: tarefas
- `StudySessions`: sessoes de estudo
- `SyncQueueEntries`: fila local de sincronizacao

Metadados offline-first em varias entidades:

- `id`
- `remoteId`
- `createdAt`
- `updatedAt`
- `syncStatus`
- `isDeleted`

Resposta pronta:

> "Eu uso soft delete com `isDeleted` para nao perder a informacao antes da
> sincronizacao. Isso e importante porque, se o usuario apaga algo offline, o
> servidor ainda precisa receber essa exclusao depois."

## Migracoes do banco

Arquivo:

```text
lib/core/database/app_database.dart
```

Ponto importante:

```dart
int get schemaVersion => 9;
```

O que explicar:

- `onCreate` cria todas as tabelas
- `onUpgrade` passa por migracoes incrementais
- `beforeOpen` ativa foreign keys, recria indices e limpa dados orfaos
- existem indices para consultas por perfil, status, sync e anexos
- existem checks para horas e duracoes nao negativas

Resposta pronta:

> "Como o aplicativo ja sofreu evolucoes, eu nao apago o banco quando muda a
> estrutura. O Drift executa migracoes incrementais para preservar os dados do
> usuario."

## Como uma disciplina e salva

Fluxo real:

```text
Tela de formulario
  -> CourseSubjectFormController
  -> CourseSubjectRepository
  -> DriftCourseSubjectRepository
  -> AppDatabase / Drift
  -> SyncQueueService
```

Arquivos:

```text
lib/features/course_subjects/presentation/pages/course_subject_form_page.dart
lib/features/course_subjects/presentation/providers/course_subject_form_controller.dart
lib/features/course_subjects/data/repositories/drift_course_subject_repository.dart
lib/core/sync/sync_queue_service.dart
```

O que acontece:

- a tela valida os campos
- o controller monta a entidade `CourseSubject`
- a entidade recebe id, timestamps e `syncStatus`
- o repositorio salva no Drift
- a mesma operacao entra na fila local de sync

Resposta pronta:

> "A tela nao salva direto no banco. Ela delega para um controller e para um
> repositorio. Isso deixa a UI mais limpa e concentra regra de persistencia na
> camada de dados."

## Como funcionam aulas e anexos

Arquivos de aulas:

```text
lib/features/course_subjects/domain/entities/course_subject_lesson.dart
lib/features/course_subjects/presentation/pages/course_subject_lesson_form_page.dart
lib/features/course_subjects/presentation/providers/course_subject_lesson_form_controller.dart
```

Arquivos de anexos:

```text
lib/core/attachments/drift_attachment_repository.dart
lib/shared/widgets/attachment_editor_section.dart
lib/shared/widgets/attachment_list_section.dart
lib/core/attachments/attachment_file_opener_io.dart
lib/core/attachments/attachment_file_opener_web.dart
```

O que o app faz hoje:

- permite anexar multiplos arquivos
- aceita arquivo generico, nao so PDF
- classifica o anexo por categoria, como documento, atividade ou slide
- permite prazo para categorias que suportam entrega
- salva os bytes localmente na tabela `Attachments`
- abre/salva copia do arquivo no desktop/mobile/web

Ponto honesto para banca:

> "A API de arquivos ja existe no backend, mas o app ainda trata os anexos
> principalmente no banco local. A etapa futura e sincronizar/uploadar esses
> anexos para o storage remoto."

## Como funciona backup JSON

Arquivo:

```text
lib/core/backup/backup_service.dart
```

O que ele faz:

- exporta dados para um JSON legivel
- inclui `schemaVersion`
- valida ids duplicados
- valida referencias entre entidades
- cria restore point antes de importacao destrutiva
- permite restaurar o restore point se o usuario importou arquivo errado

Resposta pronta:

> "O backup JSON e uma estrategia de portabilidade manual enquanto a sync ainda
> esta evoluindo. Ele tambem serve como camada de seguranca antes de alterar ou
> trocar dados locais."

## Onde esta a API do backend

Entrada do servidor:

```text
backend/src/server.ts
```

Factory da API:

```text
backend/src/app.ts
```

Configuracao:

```text
backend/src/config/env.ts
```

Banco remoto:

```text
backend/prisma/schema.prisma
backend/src/db/prisma.ts
```

Modulos:

```text
backend/src/modules/auth
backend/src/modules/sync
backend/src/modules/files
```

Resposta pronta:

> "O backend e uma API Fastify. O `server.ts` sobe o servidor, o `app.ts` registra
> plugins e rotas, e os modulos separam autenticacao, sincronizacao e arquivos."

## Healthcheck e readiness

Rotas:

```text
GET /health
GET /ready
```

Explicacao:

- `/health` mostra que o processo da API esta vivo
- `/ready` valida API, PostgreSQL/Prisma e a pasta de storage
- se `/health` funciona e `/ready` falha, a API subiu, mas banco ou anexos
  precisam de ajuste

Resposta pronta:

> "Eu separei liveness de readiness. Isso evita dizer que o backend esta pronto
> so porque o processo respondeu. Para demo tecnica, `/ready` e o teste mais
> honesto."

## Como o backend conecta no banco de dados

Arquivo do Prisma:

```text
backend/prisma/schema.prisma
```

Arquivo que cria o client:

```text
backend/src/db/prisma.ts
```

Variavel usada:

```text
DATABASE_URL
```

Explicacao:

- o backend usa PostgreSQL
- a conexao vem do `.env` por `DATABASE_URL`
- o Prisma gera o cliente para acessar as tabelas
- o Flutter nunca acessa esse banco direto

Resposta pronta:

> "O app local usa SQLite. O servidor usa PostgreSQL. Quem conversa com o
> PostgreSQL e somente o backend via Prisma. Isso protege o banco e centraliza
> regra de autenticacao, sync e arquivos."

## Modelos principais do banco remoto

Arquivo:

```text
backend/prisma/schema.prisma
```

Modelos:

- `User`: usuario da conta
- `RefreshToken`: refresh tokens com hash
- `PasswordResetToken`: tokens de recuperacao com hash
- `SyncDevice`: dispositivos do usuario
- `SyncEntity`: entidade generica sincronizada
- `FileObject`: metadados de arquivo no servidor

Pergunta provavel: "Por que `SyncEntity` e generica?"

Resposta:

> "Porque no comeco da sync e mais simples sincronizar payloads por entidade sem
> criar uma tabela remota especifica para cada feature. Isso reduz refatoracao
> inicial e permite evoluir depois para tabelas normalizadas se o produto pedir."

## Como o Flutter sabe qual servidor usar

Arquivo:

```text
lib/core/network/api_settings.dart
```

Configuracao:

```dart
static const defaultBaseUrl = String.fromEnvironment(
  'CAMPUSFLOW_API_BASE_URL',
  defaultValue: 'https://tswicolly03.duckdns.org/api',
);
```

Explicacao:

- por padrao, aponta para `https://tswicolly03.duckdns.org/api`
- em build, pode trocar usando `--dart-define`
- ao iniciar, o app le um endpoint salvo em `SharedPreferences`
- em Ajustes, da para salvar/restaurar endpoint, testar `/health` e limpar para
  modo local/offline
- o app usa o servidor automaticamente se existe base URL
- endpoint vazio e tratado como modo local/offline intencional

Exemplo de build:

```powershell
flutter build windows --release --dart-define=CAMPUSFLOW_API_BASE_URL=https://tswicolly03.duckdns.org/api
```

## Como o Flutter faz requisicao para a API

Arquivo:

```text
lib/core/network/api_client.dart
```

Tecnologia:

```text
package:http
```

O `ApiClient` oferece:

- `get(path)`
- `post(path, body: ...)`
- headers JSON
- Authorization Bearer
- refresh automatico quando recebe 401
- timeout padrao de 12 segundos
- tratamento de erro amigavel

Fluxo de uma requisicao autenticada:

```text
Feature/Repository
  -> ApiClient.post('/rota')
  -> ApiSessionStore le accessToken
  -> envia Authorization: Bearer <token>
  -> se receber 401, chama /auth/refresh
  -> repete a requisicao uma vez
  -> decodifica JSON ou lanca AppException
```

Onde a sessao remota e guardada:

```text
lib/core/network/api_session_store.dart
```

Ela usa:

```text
flutter_secure_storage
```

Resposta pronta:

> "As telas nao usam `http` direto. Todas as chamadas passam pelo `ApiClient`,
> que sabe montar URL, headers, token, refresh e erro padronizado."

## Rotas de autenticacao

Flutter:

```text
lib/features/auth/data/repositories/remote_auth_repository.dart
```

Backend:

```text
backend/src/modules/auth/auth.routes.ts
backend/src/modules/auth/auth.service.ts
```

Rotas:

- `POST /auth/register`
- `POST /auth/login`
- `POST /auth/google`
- `POST /auth/refresh`
- `POST /auth/logout`
- `POST /auth/password/forgot`
- `POST /auth/password/reset`
- `GET /auth/me`

Como email duplicado funciona:

Arquivo:

```text
backend/src/modules/auth/auth.service.ts
```

Regra:

- `User.email` e unico no Prisma
- cadastro com email ja existente retorna erro 409
- login Google com email existente vincula/atualiza a conta em vez de criar duplicada

Resposta pronta:

> "O email e a chave unica da conta. Duas contas com o mesmo email nao sao
> criadas, porque isso quebraria sincronizacao e autoria dos dados."

## Como a senha e protegida

No app local:

```text
lib/features/auth/data/services/password_hasher.dart
lib/features/auth/data/services/flutter_secure_auth_store.dart
```

Protecoes:

- PBKDF2 com HMAC-SHA256
- salt por usuario
- `flutter_secure_storage`

No backend:

```text
backend/src/shared/security.ts
```

Protecoes:

- `scrypt` para senha
- refresh token salvo apenas como hash SHA-256
- token de recuperacao salvo apenas como hash
- comparacao segura com `timingSafeEqual`

Resposta pronta:

> "Senha nao e salva em texto puro. No app local existe hash com PBKDF2 e no
> backend o hash usa scrypt. Tokens sensiveis tambem ficam persistidos como hash."

## Como funciona login com Google

Flutter:

```text
lib/features/auth/data/services/google_auth_service.dart
lib/features/auth/data/repositories/remote_auth_repository.dart
lib/features/auth/presentation/widgets/google_sign_in_button_web.dart
```

Backend:

```text
backend/src/modules/auth/auth.service.ts
```

Fluxo:

- Flutter abre o login Google
- Google devolve `idToken`
- Flutter envia `idToken` para `POST /auth/google`
- backend valida o token em `https://oauth2.googleapis.com/tokeninfo`
- backend confere se o `aud` esta na lista de Client IDs permitidos
- se email ja existe, vincula a conta
- se email nao existe, cria usuario novo

Resposta pronta:

> "O app nao confia apenas no cliente. O backend valida o `idToken` do Google e
> confere se ele pertence a um Client ID autorizado do CampusFlow."

## Como funciona a sincronizacao

Fila local:

```text
lib/core/sync/sync_queue_service.dart
```

Envio remoto:

```text
lib/core/sync/remote_sync_service.dart
```

Backend:

```text
backend/src/modules/sync/sync.routes.ts
backend/src/modules/sync/sync.service.ts
```

Fluxo:

```text
Usuario altera algo offline
  -> repositorio salva no Drift
  -> SyncQueueService grava/compacta item em SyncQueueEntries
  -> usuario logado ou clica "Sincronizar agora"
  -> RemoteSyncService envia lote para POST /sync/push
  -> backend grava em SyncEntity
  -> backend devolve remoteId/status
  -> app marca fila como synced ou failed
  -> app chama GET /sync/pull para buscar mudancas remotas
```

Por que existe `deviceId`:

- identifica cada instalacao
- ajuda em multi-dispositivo
- permite saber de onde veio uma alteracao

Como conflitos sao tratados hoje:

- backend compara versao base com versao do servidor
- se cliente estiver atrasado, responde `conflict`
- app marca como `failed` para tratamento posterior
- limitacao atual: o Flutter ainda nao envia `baseVersion` real do servidor em
  todos os casos
- limitacao atual: o pull remoto ainda nao aplica automaticamente dados baixados
  no banco local

Resposta pronta:

> "A sincronizacao foi desenhada como outbox local. Primeiro salvo localmente,
> depois tento enviar. Isso e mais seguro para offline-first do que depender da
> internet no momento do cadastro."

## Como o backend recebe sync

Rota:

```text
POST /sync/push
```

Arquivo:

```text
backend/src/modules/sync/sync.routes.ts
```

Servico:

```text
backend/src/modules/sync/sync.service.ts
```

Formato conceitual:

```json
{
  "clientId": "device-id",
  "deviceName": "CampusFlow",
  "changes": [
    {
      "entityType": "course_subject",
      "localId": "id-local",
      "isDeleted": false,
      "payload": {}
    }
  ]
}
```

Resposta conceitual:

```json
{
  "serverTime": "2026-06-17T00:00:00.000Z",
  "results": [
    {
      "status": "accepted",
      "entityType": "course_subject",
      "localId": "id-local",
      "remoteId": "id-remoto",
      "version": 1
    }
  ]
}
```

## Como funcionam arquivos no backend

Backend:

```text
backend/src/modules/files/file.routes.ts
backend/prisma/schema.prisma
```

Rotas:

- `POST /files/upload`
- `GET /files`
- `GET /files/:id/download`
- `DELETE /files/:id`

Storage:

```text
STORAGE_DIR
```

Ponto honesto:

> "A API ja tem endpoints de arquivo e modelo `FileObject`. No app, os anexos
> ainda ficam localmente em Drift. A proxima evolucao e ligar o upload/download
> remoto dos anexos a essa API."

## Como funciona a importacao de grade/PPC

Arquivos:

```text
lib/features/academic_profile/data/services/curriculum_file_loader.dart
lib/features/academic_profile/data/services/curriculum_document_reader.dart
lib/features/academic_profile/data/services/curriculum_import_parser.dart
lib/features/academic_profile/presentation/providers/curriculum_import_controller.dart
```

O que explicar:

- o usuario escolhe PDF/documento
- o app extrai texto
- o parser tenta identificar disciplinas, carga horaria, periodo, ementa e pre-requisitos
- antes de salvar, mostra uma previa para revisao
- isso evita criar dados errados direto no banco

Resposta pronta:

> "Importar PPC e um problema dificil porque cada faculdade formata o PDF de um
> jeito. Por isso eu trato como assistente de importacao com previa e revisao,
> nao como verdade absoluta."

## Como funciona aproveitamento de disciplinas

Arquivo:

```text
lib/features/academic_profile/data/services/course_subject_equivalence_analyzer.dart
```

Ideia:

- compara nome da disciplina
- compara ementa/conteudo
- considera carga horaria
- gera sugestoes de aproveitamento para segunda graduacao

Resposta pronta:

> "A ideia nao e substituir a analise oficial da faculdade. O app sugere
> possiveis equivalencias para o aluno organizar a solicitacao de aproveitamento."

## Como o dashboard calcula os indicadores

Arquivo:

```text
lib/features/dashboard/data/repositories/drift_dashboard_repository.dart
```

O que ele usa:

- queries agregadas SQL via Drift
- total de disciplinas
- disciplinas concluidas
- horas complementares aprovadas
- horas de estagio cumpridas
- horas de extensao aprovadas
- tempo de estudo
- lembretes de anexos com prazo
- disciplinas do dia sem aula lancada

Resposta pronta:

> "O dashboard nao precisa carregar todas as listas na memoria para calcular
> tudo. Ele usa consultas agregadas no banco local, o que escala melhor."

## Onde ficam tema, cores e UI

Arquivos:

```text
lib/core/theme/app_theme.dart
lib/core/theme/app_color_profile.dart
lib/core/theme/color_profile_controller.dart
lib/core/theme/theme_mode_controller.dart
lib/shared/widgets/app_shell.dart
```

O que explicar:

- Material 3
- tema claro e escuro
- perfil de cores personalizado
- layout adaptado para desktop/mobile via `AppShell`

Resposta pronta:

> "O app tem uma casca unica de navegacao, mas a interface se adapta ao tamanho
> de tela. Isso ajuda a manter a mesma base para Windows, Web e mobile."

## Testes automatizados

Flutter:

```text
test/
```

Backend:

```text
backend/test/
```

Testes importantes:

- `test/course_subject_repository_test.dart`
- `test/attachment_repository_test.dart`
- `test/backup_service_test.dart`
- `test/remote_sync_service_test.dart`
- `test/api_client_test.dart`
- `test/auth_repository_test.dart`
- `backend/test/auth-registration.test.ts`
- `backend/test/sync-conflict.test.ts`
- `backend/test/security.test.ts`

Comandos:

```powershell
flutter analyze
flutter test
cd backend
npm run build
npm run test
```

Resposta pronta:

> "Eu testei repositorios, backup, sync, API client e autenticacao. Isso cobre as
> regras principais sem depender da interface visual."

## Deploy e servidor

Servidor usado no projeto:

```text
https://tswicolly03.duckdns.org/api
```

Arquivos de deploy:

```text
backend/deploy/vinhedo/deploy.ps1
backend/deploy/vinhedo/Caddyfile.example
backend/deploy/vinhedo/campusflow-api.service
backend/deploy/vinhedo/README.md
```

No servidor:

- API Node roda como servico `campusflow-api`
- Caddy faz proxy HTTPS para `/api`
- PostgreSQL roda via Docker
- uploads ficam no diretorio configurado por `STORAGE_DIR`

Resposta pronta:

> "O servidor nao e o app Flutter. Ele e apenas a API de sincronizacao,
> autenticacao e arquivos. O app continua sendo instalado/aberto no dispositivo
> do usuario."

## Perguntas provaveis e respostas curtas

### Por que Flutter?

Porque permite uma base unica para Android, iOS, Windows e Web, reduzindo
duplicacao de codigo.

### Por que Drift?

Porque o dominio e relacional: perfil tem disciplinas, disciplinas tem aulas,
aulas tem anexos, atividades pertencem a perfis. Drift traz SQLite com schema,
migracoes, queries e tipagem.

### Por que nao Firebase direto?

Porque o requisito inicial era offline-first com controle local e arquitetura
preparada para servidor proprio. Firebase poderia ser usado, mas prenderia mais
a modelagem e custos ao ecossistema dele.

### O app funciona sem internet?

Sim para uso local. Login remoto e sync dependem do servidor, mas dados
academicos sao salvos localmente primeiro.

### O app acessa o banco do servidor direto?

Nao. O Flutter so chama a API. O PostgreSQL fica atras do backend.

### Como evita perda de dados?

Usa banco local, soft delete, backup JSON, restore point antes de importacao e
fila de sincronizacao.

### O que acontece se o servidor cair?

O app continua funcionando localmente. A sync falha, marca a fila como `failed`
e o usuario pode tentar de novo.

### Como sabe que uma alteracao precisa sincronizar?

Repositorios salvam a entidade e chamam `SyncQueueService`, que grava a operacao
em `sync_queue_entries`.

### O que acontece com dois emails iguais?

No cadastro tradicional, o backend retorna erro 409. No Google, se o email ja
existe, a conta e vinculada/atualizada.

### Como recupera senha?

No backend existe token de recuperacao por `/auth/password/forgot` e
`/auth/password/reset`. Em producao o token nao deve ser exibido; deve ser
enviado por email.

### O que falta para vender?

Monitoramento do backend, envio real de email, storage remoto robusto para
arquivos, politica de backup, LGPD/termos, builds assinadas, publicacao nas
lojas e testes E2E.

## Sequencia sugerida para mostrar codigo

1. Abra `lib/main.dart` e explique injecao de dependencias.
2. Abra `lib/app.dart` e explique tema, router e sync automatica.
3. Abra `lib/core/router/app_router.dart` e explique login/protecao.
4. Abra `lib/core/database/app_database.dart` e mostre tabelas/migracoes.
5. Abra `lib/features/course_subjects/presentation/providers/course_subject_form_controller.dart`.
6. Abra `lib/features/course_subjects/data/repositories/drift_course_subject_repository.dart`.
7. Abra `lib/core/sync/sync_queue_service.dart`.
8. Abra `lib/core/network/api_client.dart`.
9. Abra `backend/src/app.ts`.
10. Abra `backend/src/modules/auth/auth.routes.ts`.
11. Abra `backend/src/modules/sync/sync.service.ts`.
12. Abra `backend/prisma/schema.prisma`.

## Frase final para defesa

> "O CampusFlow foi desenvolvido como um app academico offline-first. A parte
> local garante uso sem internet, e a parte remota foi adicionada como uma
> evolucao para login, multi-dispositivo e sincronizacao. A arquitetura por
> features, repositorios e providers permite crescer o projeto sem reescrever a
> interface inteira."
