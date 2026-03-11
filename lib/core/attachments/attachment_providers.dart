import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_providers.dart';
import '../sync/sync_queue_service.dart';
import 'attachment_owner_type.dart';
import 'attachment_repository.dart';
import 'drift_attachment_repository.dart';
import 'stored_attachment.dart';

final attachmentRepositoryProvider = Provider<AttachmentRepository>(
  (ref) => DriftAttachmentRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(syncQueueServiceProvider),
  ),
);

typedef AttachmentOwnerKey = ({AttachmentOwnerType ownerType, String ownerId});

final ownerAttachmentsProvider =
    StreamProvider.family<List<StoredAttachment>, AttachmentOwnerKey>(
  (ref, key) {
    return ref
        .watch(attachmentRepositoryProvider)
        .watchByOwner(key.ownerType, key.ownerId);
  },
);
