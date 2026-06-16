<!-- Signature: dev.tswicolly03 -->

# Auditoria de arquitetura e release

Data da auditoria: 2026-06-15

## Objetivo

Preparar o CampusFlow para ser liberado para outras pessoas testarem, reduzindo
incongruencias de arquitetura e aumentando a cobertura de testes dos principais
modulos do aplicativo.

## O que foi verificado

- Estrutura por features em `lib/features`.
- Separacao entre `data`, `domain` e `presentation`.
- Persistencia local com Drift.
- Fila de sincronizacao local.
- Sincronizacao remota com backend.
- Login/API client.
- Backup/importacao JSON.
- Cascata de exclusao logica em dados relacionados.
- Testes unitarios e de repositorio por modulo principal.
- Build Web, Windows e Android debug.

## Incongruencias corrigidas

### Exclusao de disciplinas

Antes, apagar uma disciplina marcava aulas como apagadas, mas nao garantia que
os anexos das aulas fossem apagados logicamente e enviados para a fila de sync.

Agora:

- disciplina entra como `pendingDelete`
- aulas da disciplina entram como `pendingDelete`
- anexos das aulas entram como `pendingDelete`
- todos os registros afetados sao adicionados/atualizados na fila local de sync

Arquivo principal:

- `lib/features/course_subjects/data/repositories/drift_course_subject_repository.dart`

### Exclusao de aula

Antes, apagar uma aula nao propagava a exclusao para os anexos daquela aula.

Agora:

- aula entra como `pendingDelete`
- anexos da aula entram como `pendingDelete`
- a fila de sync recebe delete da aula e dos anexos

### Gerenciador de estudos

Antes, alguns metodos `getAll` do gerenciador de estudos podiam retornar itens
marcados como `isDeleted`. Isso era diferente dos outros modulos.

Agora:

- `getAllSubjects`
- `getAllTopics`
- `getAllTasks`
- `getAllSessions`

retornam apenas itens ativos.

Tambem foi adicionada cascata ao apagar uma materia de estudo:

- materia de estudo
- topicos vinculados
- tarefas vinculadas
- sessoes vinculadas

## Testes adicionados

- `test/course_subject_repository_test.dart`
- `test/attachment_repository_test.dart`
- `test/academic_activity_repositories_test.dart`
- `test/study_manager_repository_test.dart`
- `test/sync_queue_service_test.dart`
- `test/remote_sync_service_test.dart`
- `test/api_client_test.dart`
- `test/test_harness.dart`

## Cobertura por area

- Auth: conta local, senha, recuperacao e Google local.
- API client: refresh token e erro amigavel do servidor.
- Perfil academico: perfil ativo unico e exclusao de dados relacionados.
- Importacao de PPC: parser, controller e equivalencia.
- Disciplinas: salvar, pre-requisitos, aulas, anexos e cascata de delete.
- Anexos: lista multipla, substituicao, conclusao e soft delete.
- Horas complementares: salvar, filtrar por perfil e delete.
- Estagios: salvar, filtrar por perfil e delete.
- Extensao: salvar, filtrar por perfil e delete.
- Estudos: materias, topicos, tarefas, sessoes e cascata de delete.
- Dashboard: agregacao sem perfil ativo.
- Backup: importacao, validacao e restore point.
- Sync: fila local compactada e envio remoto aceito pelo backend.

## Validacao executada

```powershell
flutter analyze
flutter test
npm run build
npm run test
flutter build web --release
flutter build windows --release
flutter build apk --debug
```

Resultado:

- Flutter analyze: sem issues.
- Flutter tests: 33 testes passando.
- Backend build: OK.
- Backend tests: 4 arquivos, 7 testes passando.
- Web release build: OK.
- Windows release build: OK.
- Android debug APK: OK.

## Pendencias antes de publicar oficialmente

- iOS precisa ser validado em macOS com Xcode.
- Android release precisa de keystore, `applicationId`, versionamento e teste em
  aparelho real.
- Google OAuth precisa dos Client IDs reais configurados no Google Cloud.
- Backend deve ter monitoramento, backup automatico e politica de logs antes de
  vender para terceiros.
- Storage de anexos no servidor deve evoluir para volume bem protegido ou
  storage externo como S3/R2/B2.
- Testes de widget/E2E ainda devem cobrir os fluxos visuais principais.

## Conclusao

A base esta mais consistente para liberar acesso controlado e demonstrar ao
professor. O app ja possui validacao automatizada dos principais modulos, builds
locais confirmados para Web/Windows/Android debug e uma lista clara do que ainda
falta para publicacao comercial.
