<!-- Signature: dev.tswicolly03 -->

# Mapa do codigo

Este mapa existe para facilitar sua leitura antes de apresentar o projeto. Ele
mostra onde fica cada parte importante e em qual ordem vale estudar os arquivos.

## Visao geral da arquitetura

O CampusFlow usa uma Clean Architecture simplificada por features:

- `lib/core`: infraestrutura compartilhada, como banco, rotas, tema, backup,
  rede, anexos e sincronizacao.
- `lib/shared`: widgets, enums e estados reutilizaveis.
- `lib/features`: modulos de negocio do app, cada um separado em `data`,
  `domain` e `presentation`.
- `backend`: API Node/Fastify usada para login remoto, Google, sync e arquivos.
- `test`: testes automatizados de repositorios, backup, importacao e auth.

## Ordem recomendada de leitura

1. `lib/main.dart`: ponto de entrada do Flutter.
2. `lib/app.dart`: tema, localizacao, router e sync automatico depois do login.
3. `lib/core/router/app_router.dart`: rotas e protecao de telas autenticadas.
4. `lib/core/database/app_database.dart`: schema local Drift e migracoes.
5. `lib/features/auth`: login, senha local, backend e Google.
6. `lib/features/academic_profile`: perfis, importacao de PPC e equivalencias.
7. `lib/features/course_subjects`: disciplinas, aulas, horarios e anexos.
8. `lib/core/backup/backup_service.dart`: exportacao/importacao JSON.
9. `lib/core/sync`: fila local e envio para backend.
10. `backend/src`: API, auth, sync, arquivos e configuracao.

## Como explicar a divisao por camadas

### Domain

Contem as entidades e contratos. Exemplo:

- `academic_profile/domain/entities/academic_profile.dart`
- `course_subjects/domain/entities/course_subject.dart`
- `auth/domain/repositories/auth_repository.dart`

Essa camada descreve o que o app entende como "perfil", "disciplina", "aula",
"sessao" e "conta", sem depender diretamente da tela ou do banco.

### Data

Contem a implementacao concreta. Exemplo:

- `drift_academic_profile_repository.dart`
- `drift_course_subject_repository.dart`
- `remote_auth_repository.dart`
- `hybrid_auth_repository.dart`

Essa camada fala com Drift, Secure Storage, API HTTP e outros detalhes tecnicos.

### Presentation

Contem paginas, formularios e controllers Riverpod. Exemplo:

- `academic_profile_page.dart`
- `course_subject_form_controller.dart`
- `login_form_controller.dart`

Aqui a tela coleta dados, mas a regra principal fica nos controllers e
repositorios para nao deixar a UI virar uma mistura de layout com regra de
negocio.

## Arquivos que valem mostrar ao professor

### Entrada e arquitetura

- `lib/main.dart`
- `lib/app.dart`
- `lib/core/router/app_router.dart`

Mostram como o app inicializa, injeta dependencias e controla rotas.

### Persistencia local

- `lib/core/database/app_database.dart`
- `lib/core/database/database_providers.dart`

Mostram que o app nao e apenas visual: ele possui banco local real, constraints,
indices e migracoes.

### Importacao de grade

- `lib/features/academic_profile/data/services/curriculum_document_reader.dart`
- `lib/features/academic_profile/data/services/curriculum_import_parser.dart`
- `lib/features/academic_profile/presentation/providers/curriculum_import_controller.dart`

Mostram o fluxo de importar PPC/PDF, extrair disciplinas e criar/atualizar um
perfil academico.

### Aproveitamento de disciplinas

- `lib/features/academic_profile/data/services/course_subject_equivalence_analyzer.dart`

Mostra a regra que compara nome, ementa e carga horaria para sugerir disciplinas
que podem ser aproveitadas em uma segunda graduacao.

### Aulas e anexos

- `lib/features/course_subjects/presentation/providers/course_subject_lesson_form_controller.dart`
- `lib/core/attachments`

Mostram como o app salva aulas, arquivos, categorias e prazos.

### Backup e sincronizacao

- `lib/core/backup/backup_service.dart`
- `lib/core/sync/sync_queue_service.dart`
- `lib/core/sync/remote_sync_service.dart`

Mostram a estrategia offline-first: primeiro salva local, depois exporta ou
sincroniza.

### Backend

- `backend/src/app.ts`
- `backend/src/modules/auth/auth.service.ts`
- `backend/src/modules/sync/sync.service.ts`
- `backend/src/modules/files/file.routes.ts`

Mostram a API, autenticacao, fila de sync e anexos no servidor.

## Como explicar um fluxo completo

Exemplo: salvar uma disciplina.

1. A tela coleta os campos no formulario.
2. O controller `CourseSubjectFormController` monta a entidade.
3. A entidade recebe metadados de sync, como `syncStatus`.
4. O repositorio salva no Drift.
5. A alteracao entra na fila local de sync.
6. Quando o usuario esta autenticado, `RemoteSyncService` envia a fila para API.

Essa sequencia mostra o motivo de separar UI, controller, repositorio, banco e
sync.

## Observacao sobre arquivos gerados

Arquivos `*.g.dart` e `*.freezed.dart` sao gerados por ferramentas. Eles nao
precisam ser explicados linha a linha. Na apresentacao, diga que eles sao
resultado de `build_runner`, `freezed`, `json_serializable` e Drift.
