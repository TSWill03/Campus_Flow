// Signature: dev.tswicolly03

import 'package:freezed_annotation/freezed_annotation.dart';

import '../sync/sync_status.dart';
import 'attachment_category.dart';
import 'attachment_owner_type.dart';

part 'stored_attachment.freezed.dart';
part 'stored_attachment.g.dart';

@freezed
abstract class StoredAttachment with _$StoredAttachment {
  const factory StoredAttachment({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    required AttachmentOwnerType ownerType,
    required String ownerId,
    required String fileName,
    required List<int> bytes,
    String? mimeType,
    required AttachmentCategory category,
    DateTime? dueDate,
    @Default(false) bool isCompleted,
  }) = _StoredAttachment;

  factory StoredAttachment.fromJson(Map<String, dynamic> json) =>
      _$StoredAttachmentFromJson(json);
}
