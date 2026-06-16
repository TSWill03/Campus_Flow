// Signature: dev.tswicolly03

import 'package:flutter_test/flutter_test.dart';

import 'package:campus_flow/core/attachments/attachment_category.dart';
import 'package:campus_flow/core/attachments/attachment_owner_type.dart';
import 'package:campus_flow/core/attachments/drift_attachment_repository.dart';
import 'package:campus_flow/core/attachments/stored_attachment.dart';
import 'package:campus_flow/core/sync/sync_status.dart';

import 'test_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DriftAttachmentRepository', () {
    late RepositoryTestHarness harness;
    late DriftAttachmentRepository repository;

    setUp(() async {
      harness = await createRepositoryTestHarness();
      repository = DriftAttachmentRepository(
        harness.database,
        harness.syncQueueService,
      );
    });

    tearDown(() async {
      await harness.close();
    });

    test('replaces attachment list and soft deletes removed files', () async {
      final first = _attachment(id: 'attachment-1', fileName: 'slide.pdf');
      final second = _attachment(id: 'attachment-2', fileName: 'codigo.rar');

      await repository.replaceForOwner(
        ownerType: AttachmentOwnerType.courseSubjectLesson,
        ownerId: 'lesson-1',
        attachments: [first, second],
      );
      await repository.updateCompletionStatus(
        attachmentId: first.id,
        isCompleted: true,
      );
      await repository.replaceForOwner(
        ownerType: AttachmentOwnerType.courseSubjectLesson,
        ownerId: 'lesson-1',
        attachments: [first.copyWith(isCompleted: true)],
      );

      final visible = await repository.getByOwner(
        AttachmentOwnerType.courseSubjectLesson,
        'lesson-1',
      );
      final deletedSecond = await (harness.database.select(
        harness.database.attachments,
      )..where((table) => table.id.equals(second.id))).getSingle();
      final queueById = {
        for (final entry in await harness.queueEntries()) entry.id: entry,
      };

      expect(visible, hasLength(1));
      expect(visible.single.id, first.id);
      expect(visible.single.isCompleted, isTrue);
      expect(deletedSecond.isDeleted, isTrue);
      expect(queueById['attachment::attachment-1']?.operation, 'upsert');
      expect(queueById['attachment::attachment-2']?.operation, 'delete');
    });
  });
}

StoredAttachment _attachment({required String id, required String fileName}) {
  final now = DateTime(2026, 6, 3, 12);
  return StoredAttachment(
    id: id,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    ownerType: AttachmentOwnerType.courseSubjectLesson,
    ownerId: 'lesson-1',
    fileName: fileName,
    bytes: const [10, 20, 30],
    mimeType: 'application/octet-stream',
    category: AttachmentCategory.document,
  );
}
