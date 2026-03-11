import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../data/repositories/drift_study_manager_repository.dart';
import '../../domain/entities/study_session.dart';
import '../../domain/entities/study_subject.dart';
import '../../domain/entities/study_task.dart';
import '../../domain/entities/study_topic.dart';
import '../../domain/repositories/study_manager_repository.dart';

final studyManagerRepositoryProvider = Provider<StudyManagerRepository>(
  (ref) => DriftStudyManagerRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(syncQueueServiceProvider),
  ),
);

final studySubjectsProvider = StreamProvider<List<StudySubject>>(
  (ref) => ref.watch(studyManagerRepositoryProvider).watchSubjects(),
);

final studySubjectByIdProvider =
    FutureProvider.family<StudySubject?, String>((ref, id) {
  return ref.watch(studyManagerRepositoryProvider).findSubjectById(id);
});

final studyTopicsProvider =
    StreamProvider.family<List<StudyTopic>, String>((ref, subjectId) {
  return ref.watch(studyManagerRepositoryProvider).watchTopics(subjectId);
});

final studyAllTopicsProvider = FutureProvider<List<StudyTopic>>((ref) {
  return ref.watch(studyManagerRepositoryProvider).getAllTopics();
});

final studyTopicByIdProvider =
    FutureProvider.family<StudyTopic?, String>((ref, id) {
  return ref.watch(studyManagerRepositoryProvider).findTopicById(id);
});

final studyTasksProvider = StreamProvider<List<StudyTask>>(
  (ref) => ref.watch(studyManagerRepositoryProvider).watchTasks(),
);

final studyTaskByIdProvider =
    FutureProvider.family<StudyTask?, String>((ref, id) {
  return ref.watch(studyManagerRepositoryProvider).findTaskById(id);
});

final studySessionsProvider = StreamProvider<List<StudySession>>(
  (ref) => ref.watch(studyManagerRepositoryProvider).watchSessions(),
);

final studySessionByIdProvider =
    FutureProvider.family<StudySession?, String>((ref, id) {
  return ref.watch(studyManagerRepositoryProvider).findSessionById(id);
});
