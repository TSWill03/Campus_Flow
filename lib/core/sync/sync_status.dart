// Signature: dev.tswicolly03

import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum SyncStatus {
  pendingCreate,
  pendingUpdate,
  pendingDelete,
  synced,
}

extension SyncStatusX on SyncStatus {
  String get label => switch (this) {
        SyncStatus.pendingCreate => 'Pendente de criacao',
        SyncStatus.pendingUpdate => 'Pendente de atualizacao',
        SyncStatus.pendingDelete => 'Pendente de exclusao',
        SyncStatus.synced => 'Sincronizado',
      };
}
