import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../sync/sync_queue_service.dart';
import '../sync/sync_status.dart';
import 'attachment_category.dart';
import 'attachment_owner_type.dart';
import 'attachment_repository.dart';
import 'stored_attachment.dart';

class DriftAttachmentRepository implements AttachmentRepository {
  DriftAttachmentRepository(this._database, this._syncQueueService);

  final AppDatabase _database;
  final SyncQueueService _syncQueueService;

  @override
  Stream<List<StoredAttachment>> watchByOwner(
    AttachmentOwnerType ownerType,
    String ownerId,
  ) {
    final query = _database.select(_database.attachments)
      ..where(
        (table) =>
            table.isDeleted.equals(false) &
            table.ownerType.equals(ownerType.dbValue) &
            table.ownerId.equals(ownerId),
      )
      ..orderBy([
        (table) => OrderingTerm.asc(table.createdAt),
      ]);

    return query.watch().map((rows) => rows.map(_mapRow).toList());
  }

  @override
  Future<List<StoredAttachment>> getByOwner(
    AttachmentOwnerType ownerType,
    String ownerId,
  ) async {
    final query = _database.select(_database.attachments)
      ..where(
        (table) =>
            table.isDeleted.equals(false) &
            table.ownerType.equals(ownerType.dbValue) &
            table.ownerId.equals(ownerId),
      );

    final rows = await query.get();
    return rows.map(_mapRow).toList();
  }

  @override
  Future<List<StoredAttachment>> getAllAttachments() async {
    final rows = await (_database.select(_database.attachments)
          ..where((table) => table.isDeleted.equals(false)))
        .get();
    return rows.map(_mapRow).toList();
  }

  @override
  Future<void> replaceForOwner({
    required AttachmentOwnerType ownerType,
    required String ownerId,
    required List<StoredAttachment> attachments,
  }) async {
    final existingRows = await (_database.select(_database.attachments)
          ..where(
            (table) =>
                table.ownerType.equals(ownerType.dbValue) &
                table.ownerId.equals(ownerId),
          ))
        .get();
    final existingIds = existingRows.map((row) => row.id).toSet();
    final nextIds = attachments.map((attachment) => attachment.id).toSet();
    final deletedIds = existingIds.difference(nextIds);

    await _database.transaction(() async {
      for (final attachment in attachments) {
        await _database.into(_database.attachments).insertOnConflictUpdate(
              AttachmentsCompanion(
                id: Value(attachment.id),
                remoteId: Value(attachment.remoteId),
                createdAt: Value(attachment.createdAt),
                updatedAt: Value(attachment.updatedAt),
                syncStatus: Value(attachment.syncStatus.name),
                isDeleted: Value(attachment.isDeleted),
                ownerType: Value(attachment.ownerType.dbValue),
                ownerId: Value(attachment.ownerId),
                fileName: Value(attachment.fileName),
                fileBytes: Value(Uint8List.fromList(attachment.bytes)),
                mimeType: Value(attachment.mimeType),
                category: Value(attachment.category.name),
                dueDate: Value(attachment.dueDate),
                isCompleted: Value(attachment.isCompleted),
              ),
            );
        await _syncQueueService.enqueueUpsert(
          entityType: 'attachment',
          entityId: attachment.id,
          entityVersion: attachment.updatedAt.millisecondsSinceEpoch,
          payload: attachment.toJson(),
        );
      }

      if (deletedIds.isNotEmpty) {
        final now = DateTime.now();
        for (final id in deletedIds) {
          await (_database.update(_database.attachments)
                ..where((table) => table.id.equals(id)))
              .write(
            AttachmentsCompanion(
              isDeleted: const Value(true),
              updatedAt: Value(now),
              syncStatus: Value(SyncStatus.pendingDelete.name),
            ),
          );
          await _syncQueueService.enqueueDelete(
            entityType: 'attachment',
            entityId: id,
            entityVersion: now.millisecondsSinceEpoch,
            payload: {
              'id': id,
              'isDeleted': true,
              'updatedAt': now.toIso8601String(),
              'syncStatus': SyncStatus.pendingDelete.name,
            },
          );
        }
      }
    });
  }

  @override
  Future<void> updateCompletionStatus({
    required String attachmentId,
    required bool isCompleted,
  }) async {
    final now = DateTime.now();
    await (_database.update(_database.attachments)
          ..where((table) => table.id.equals(attachmentId)))
        .write(
      AttachmentsCompanion(
        isCompleted: Value(isCompleted),
        updatedAt: Value(now),
        syncStatus: Value(SyncStatus.pendingUpdate.name),
      ),
    );

    final row = await (_database.select(_database.attachments)
          ..where((table) => table.id.equals(attachmentId))
          ..limit(1))
        .getSingleOrNull();
    if (row == null) {
      return;
    }

    final attachment = _mapRow(row);
    await _syncQueueService.enqueueUpsert(
      entityType: 'attachment',
      entityId: attachment.id,
      entityVersion: attachment.updatedAt.millisecondsSinceEpoch,
      payload: attachment.toJson(),
    );
  }

  StoredAttachment _mapRow(AttachmentRow row) {
    return StoredAttachment(
      id: row.id,
      remoteId: row.remoteId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: SyncStatus.values.byName(row.syncStatus),
      isDeleted: row.isDeleted,
      ownerType: AttachmentOwnerType.values.firstWhere(
        (value) => value.dbValue == row.ownerType,
      ),
      ownerId: row.ownerId,
      fileName: row.fileName,
      bytes: row.fileBytes,
      mimeType: row.mimeType,
      category: AttachmentCategory.values.byName(row.category),
      dueDate: row.dueDate,
      isCompleted: row.isCompleted,
    );
  }
}
