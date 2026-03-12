// Signature: dev.tswicolly03

import 'attachment_owner_type.dart';
import 'stored_attachment.dart';

abstract interface class AttachmentRepository {
  Stream<List<StoredAttachment>> watchByOwner(
    AttachmentOwnerType ownerType,
    String ownerId,
  );

  Future<List<StoredAttachment>> getByOwner(
    AttachmentOwnerType ownerType,
    String ownerId,
  );

  Future<List<StoredAttachment>> getAllAttachments();

  Future<void> replaceForOwner({
    required AttachmentOwnerType ownerType,
    required String ownerId,
    required List<StoredAttachment> attachments,
  });

  Future<void> updateCompletionStatus({
    required String attachmentId,
    required bool isCompleted,
  });
}
