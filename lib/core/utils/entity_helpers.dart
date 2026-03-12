// Signature: dev.tswicolly03

import '../sync/sync_status.dart';

SyncStatus resolveUpsertSyncStatus(SyncStatus? currentStatus) {
  if (currentStatus == null || currentStatus == SyncStatus.pendingCreate) {
    return SyncStatus.pendingCreate;
  }

  return SyncStatus.pendingUpdate;
}
