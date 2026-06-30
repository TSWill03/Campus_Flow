// Signature: dev.tswicolly03

import 'package:flutter_test/flutter_test.dart';

import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/study_manager/data/repositories/drift_study_manager_repository.dart';
import 'package:campus_flow/features/study_manager/domain/entities/study_session.dart';
import 'package:campus_flow/features/study_manager/domain/entities/study_subject.dart';
import 'package:campus_flow/features/study_manager/domain/entities/study_task.dart';
import 'package:campus_flow/features/study_manager/domain/entities/study_topic.dart';
import 'package:campus_flow/shared/enums/app_enums.dart';

import 'test_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DriftStudyManagerRepository', () {
    late RepositoryTestHarness harness;
    late DriftStudyManagerRepository repository;

    setUp(() async {
      harness = await createRepositoryTestHarness();
      repository = DriftStudyManagerRepository(
        harness.database,
        harness.syncQueueService,
      );
    });

    tearDown(() async {
      await harness.close();
    });

    test('saves study entities and cascades subject deletion', () async {
      await harness.insertAcademicProfile(id: 'profile-1');
      final subject = _subject();
      final topic = _topic(subject.id);
      final task = _task(subject.id);
      final session = _session(subject.id, topic.id);

      await repository.saveSubject(subject);
      await repository.saveTopic(topic);
      await repository.saveTask(task);
      await repository.saveSession(session);

      expect(await repository.getAllSubjects(), hasLength(1));
      expect(await repository.getAllTopics(), hasLength(1));
      expect(await repository.getAllTasks(), hasLength(1));
      expect(await repository.getAllSessions(), hasLength(1));
      expect(
        await repository.getAllSessions(academicProfileId: 'profile-1'),
        hasLength(1),
      );
      expect(
        await repository.getAllSessions(academicProfileId: 'profile-2'),
        isEmpty,
      );

      await repository.deleteSubject(subject.id);
      final queueById = {
        for (final entry in await harness.queueEntries()) entry.id: entry,
      };

      expect(await repository.getAllSubjects(), isEmpty);
      expect(await repository.getAllTopics(), isEmpty);
      expect(await repository.getAllTasks(), isEmpty);
      expect(await repository.getAllSessions(), isEmpty);
      expect(queueById['study_subject::study-subject-1']?.operation, 'delete');
      expect(queueById['study_topic::topic-1']?.operation, 'delete');
      expect(queueById['study_task::task-1']?.operation, 'delete');
      expect(queueById['study_session::session-1']?.operation, 'delete');
    });
  });
}

StudySubject _subject() {
  final now = DateTime(2026, 6, 7, 9);
  return StudySubject(
    id: 'study-subject-1',
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    name: 'Flutter',
    colorValue: 0xFF0F766E,
    description: 'Estudos de arquitetura Flutter.',
  );
}

StudyTopic _topic(String subjectId) {
  final now = DateTime(2026, 6, 7, 10);
  return StudyTopic(
    id: 'topic-1',
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    studySubjectId: subjectId,
    name: 'Riverpod',
    status: StudyTopicStatus.studying,
  );
}

StudyTask _task(String subjectId) {
  final now = DateTime(2026, 6, 7, 11);
  return StudyTask(
    id: 'task-1',
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    title: 'Criar testes',
    studySubjectId: subjectId,
    dueDate: DateTime(2026, 6, 10),
    priority: StudyTaskPriority.high,
    status: StudyTaskStatus.inProgress,
  );
}

StudySession _session(String subjectId, String topicId) {
  final now = DateTime(2026, 6, 7, 12);
  return StudySession(
    id: 'session-1',
    createdAt: now,
    updatedAt: now,
    syncStatus: SyncStatus.pendingCreate,
    isDeleted: false,
    academicProfileId: 'profile-1',
    studySubjectId: subjectId,
    studyTopicId: topicId,
    startedAt: now,
    endedAt: now.add(const Duration(minutes: 90)),
    durationMinutes: 90,
  );
}
