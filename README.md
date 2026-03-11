# CampusFlow

CampusFlow e um gerenciador academico pessoal offline-first para estudantes universitarios. O app centraliza perfil academico, disciplinas, horas obrigatorias, organizacao de estudos e backup local em JSON, sem depender de backend no MVP.

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
