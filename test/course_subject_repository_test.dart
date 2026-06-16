// Signature: dev.tswicolly03

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:campus_flow/core/attachments/attachment_category.dart';
import 'package:campus_flow/core/attachments/attachment_owner_type.dart';
import 'package:campus_flow/core/attachments/drift_attachment_repository.dart';
import 'package:campus_flow/core/attachments/stored_attachment.dart';
import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/course_subjects/data/repositories/drift_course_subject_repository.dart';
import 'package:campus_flow/features/course_subjects/domain/entities/course_subject.dart';
import 'package:campus_flow/features/course_subjects/domain/entities/course_subject_lesson.dart';
import 'package:campus_flow/shared/enums/app_enums.dart';

import 'test_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DriftCourseSubjectRepository', () {
    late RepositoryTestHarness harness;
    late DriftCourseSubjectRepository repository;
    late DriftAttachmentRepository attachmentRepository;

    setUp(() async {
      harness = await createRepositoryTestHarness();
      await harness.insertAcademicProfile(id: 'profile-1');
      repository = DriftCourseSubjectRepository(
        harness.database,
        harness.syncQueueService,
      );
      attachmentRepository = DriftAttachmentRepository(
        harness.database,
        harness.syncQueueService,
      );
    });

    tearDown(() async {
      await harness.close();
    });

    test(
      'saves subjects with prerequisites and enqueues sync payload',
      () async {
        final subject = _subject(
          id: 'subject-1',
          academicProfileId: 'profile-1',
          prerequisiteSubjectIds: const ['pre-1', 'pre-2'],
        );

        await repository.saveSubject(subject);

        final saved = await repository.findById('subject-1');
        final profileSubjects = await repository.getAllSubjects(
          academicProfileId: 'profile-1',
        );
        final queueEntries = await harness.queueEntries();
        final payload =
            jsonDecode(queueEntries.single.payloadJson) as Map<String, dynamic>;

        expect(saved?.name, 'Algoritmos');
        expect(saved?.prerequisiteSubjectIds, ['pre-1', 'pre-2']);
        expect(profileSubjects, hasLength(1));
        expect(queueEntries.single.entityType, 'course_subject');
        expect(queueEntries.single.operation, 'upsert');
        expect(payload['name'], 'Algoritmos');
      },
    );

    test('deletes lesson and linked attachments as soft deletes', () async {
      final subject = _subject(id: 'subject-1');
      final lesson = _lesson(id: 'lesson-1', subjectId: subject.id);
      final attachment = _attachment(id: 'attachment-1', ownerId: lesson.id);

      await repository.saveSubject(subject);
      await repository.saveLesson(lesson);
      await attachmentRepository.replaceForOwner(
        ownerType: AttachmentOwnerType.courseSubjectLesson,
        ownerId: lesson.id,
        attachments: [attachment],
      );

      await repository.deleteLesson(lesson.id);

      final visibleLessons = await repository.getAllLessons(
        subjectId: subject.id,
      );
      final visibleAttachments = await attachmentRepository.getByOwner(
        AttachmentOwnerType.courseSubjectLesson,
        lesson.id,
      );
      final deletedLesson = await repository.findLessonById(lesson.id);
      final queueById = {
        for (final entry in await harness.queueEntries()) entry.id: entry,
      };

      expect(visibleLessons, isEmpty);
      expect(visibleAttachments, isEmpty);
      expect(deletedLesson?.isDeleted, isTrue);
      expect(queueById['course_subject_lesson::lesson-1']?.operation, 'delete');
      expect(queueById['attachment::attachment-1']?.operation, 'delete');
    });

    test('deletes subject, lessons and lesson attachments together', () async {
      final subject = _subject(id: 'subject-1');
      final lesson = _lesson(id: 'lesson-1', subjectId: subject.id);
      final attachment = _attachment(id: 'attachment-1', ownerId: lesson.id);

      await repository.saveSubject(subject);
      await repository.saveLesson(lesson);
      await attachmentRepository.replaceForOwner(
        ownerType: AttachmentOwnerType.courseSubjectLesson,
        ownerId: lesson.id,
        attachments: [attachment],
      );

      await repository.deleteSubject(subject.id);

      final queueById = {
        for (final entry in await harness.queueEntries()) entry.id: entry,
      };

      expect(await repository.getAllSubjects(), isEmpty);
      expect(await repository.getAllLessons(subjectId: subject.id), isEmpty);
      expect(
        await attachmentRepository.getByOwner(
          AttachmentOwnerType.courseSubjectLesson,
          lesson.id,
        ),
        isEmpty,
      );
      expect(queueById['course_subject::subject-1']?.operation, 'delete');
      expect(queueById['course_subject_lesson::lesson-1']?.operation, 'delete');
      expect(queueById['attachment::attachment-1']?.operation, 'delete');
    });
  });
}

CourseSubject _subject({
  required String id,
  String academicProfileId = 'profile-1',
  List<String> prerequisiteSubjectIds = const [],
}) {
  final now = DateTime(2026, 6, 1, 8);
  return CourseSubject(
    id: id,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    academicProfileId: academicProfileId,
    name: 'Algoritmos',
    code: 'BCC001',
    workloadHours: 72,
    electiveHours: null,
    suggestedSemester: 1,
    prerequisiteSubjectIds: prerequisiteSubjectIds,
    scheduledWeekday: DateTime.monday,
    defaultLessonHours: 4,
    type: CourseSubjectType.mandatory,
    status: CourseSubjectStatus.inProgress,
    syllabus: 'Logica, variaveis, estruturas de decisao e repeticao.',
  );
}

CourseSubjectLesson _lesson({required String id, required String subjectId}) {
  final now = DateTime(2026, 6, 2, 10);
  return CourseSubjectLesson(
    id: id,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    courseSubjectId: subjectId,
    lessonDate: now,
    lessonHours: 4,
    coveredContent: 'Introducao a algoritmos',
    activityDescription: 'Lista 1',
    assessmentDate: DateTime(2026, 6, 9),
  );
}

StoredAttachment _attachment({required String id, required String ownerId}) {
  final now = DateTime(2026, 6, 2, 11);
  return StoredAttachment(
    id: id,
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    ownerType: AttachmentOwnerType.courseSubjectLesson,
    ownerId: ownerId,
    fileName: 'lista.zip',
    bytes: const [1, 2, 3],
    mimeType: 'application/zip',
    category: AttachmentCategory.activity,
    dueDate: DateTime(2026, 6, 10),
  );
}
