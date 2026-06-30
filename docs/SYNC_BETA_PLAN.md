<!-- Signature: dev.tswicolly03 -->

# CampusFlow - Plano de Sync para Beta

## Estado atual

Implementado:

- Todas as tabelas principais possuem `id`, `remoteId`, `createdAt`,
  `updatedAt`, `syncStatus` e `isDeleted`.
- Alteracoes locais entram em `sync_queue_entries`.
- `RemoteSyncService.syncNow()` envia a fila para `POST /sync/push`.
- Quando o backend aceita uma entidade, o app grava `remoteId` e
  `syncStatus=synced`.
- O app chama `GET /sync/pull` e salva cursor simples em
  `remote_sync_pull_cursor`.

Parcial:

- O resultado de `/sync/pull` ainda e apenas lido e contado. Ele nao e aplicado
  no Drift local.
- `baseVersion` real ainda nao e enviado pela fila local.
- Conflitos viram falha de fila, mas ainda nao possuem tela de revisao.

## Como aplicar `/sync/pull` no Drift local

1. Criar um mapper por `entityType` em `RemoteSyncService`.
2. Para cada change recebido:
   - localizar registro por `remoteId`;
   - se nao existir, tentar localizar por `id/localId` quando for uma primeira
     vinculacao segura;
   - se nao existir nenhum, inserir com novo `id` local preservando `remoteId`;
   - se existir e nao houver conflito local, atualizar campos permitidos;
   - se `isDeleted=true`, aplicar soft delete local.
3. Executar tudo dentro de `database.transaction`.
4. Atualizar o cursor apenas depois que todas as mudancas forem aplicadas.
5. Nunca baixar ou aplicar `payload` de anexo com bytes/PDF dentro da sync
   generica; anexos devem continuar pela API de arquivos.

## Resolucao de conflitos

Politica recomendada para beta:

- Entidades editadas apenas no servidor: aplicar automaticamente.
- Entidades locais com `syncStatus=synced`: aplicar automaticamente.
- Entidades locais com `pendingCreate`, `pendingUpdate` ou `pendingDelete`:
  criar conflito local e nao sobrescrever.
- Conflito manual deve guardar:
  - `entityType`;
  - `localId`;
  - `remoteId`;
  - `localPayload`;
  - `serverPayload`;
  - `serverVersion`;
  - `detectedAt`.

Tela futura:

- Mostrar entidade afetada com linguagem comum.
- Permitir "manter meu dado", "usar dado do servidor" ou "revisar depois".
- Nao mostrar payload bruto com campos sensiveis.

## Fila pendente no app

O app ja mostra:

- pendencias;
- falhas;
- ultima sincronizacao;
- botao `Sincronizar agora`;
- botao `Descartar fila antiga`.

Melhoria recomendada:

- Criar tela de fila com agrupamento por entidade.
- Mostrar status `pendente`, `enviando`, `falhou`, `conflito`.
- Permitir reenviar item individual.
- Permitir descartar apenas um item depois de confirmacao.

## Evitar duplicacao local/remota

Regras:

- `id` local nunca deve ser substituido pelo `remoteId`.
- `remoteId` deve ser unico por tabela quando preenchido.
- Ao aplicar pull, procurar primeiro por `remoteId`.
- Usar `localId` vindo do servidor apenas como pista de primeira vinculacao.
- Depois que `remoteId` existir, ele passa a ser a chave de reconciliacao.

Risco atual:

- Como `remoteId` ainda nao tem constraint unica no Drift, uma aplicacao futura
  de pull mal feita pode duplicar entidades. Antes da beta ampla, adicionar
  indices unicos parciais por tabela onde SQLite/Drift permitir.

## Campos por tabela

Ja existem na base:

- `remoteId`
- `syncStatus`
- `createdAt`
- `updatedAt`
- `isDeleted`

Ainda recomendado:

- `entityVersion` em cada tabela de dominio, nao apenas na fila.
- `lastSyncedAt` por entidade.
- `lastSyncError` opcional por entidade ou por fila.

Tabelas que precisam manter esses campos:

- `academic_profiles`
- `course_subjects`
- `course_subject_lessons`
- `attachments`
- `complementary_activities`
- `internships`
- `extension_activities`
- `study_subjects`
- `study_topics`
- `study_tasks`
- `study_sessions`

## Riscos antes da beta publica

- Pull ainda nao materializa dados remotos no dispositivo.
- Conflitos nao tem UX de decisao.
- Sem `entityVersion` persistido na entidade local, o cliente nao prova qual
  versao do servidor editou.
- Anexos ainda dependem de storage local persistente no servidor.
- Sync generica com payload JSON exige allowlist por entidade antes de escalar.
- Falta job operacional para backup e restauracao testada.

## Melhorias pequenas seguras feitas agora

- Falhas de envio da fila geram report `sync_error` sem payload academico.
- Ajustes exibem estado de sync: `sincronizado`, `pendente`, `falhou` ou
  `offline`.
- Fila de reports de erro e reenviada quando o endpoint da API fica disponivel.
