// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../data/repositories/drift_course_subject_repository.dart';
import '../../domain/entities/course_subject.dart';
import '../../domain/entities/course_subject_lesson.dart';
import '../../domain/repositories/course_subject_repository.dart';

final courseSubjectRepositoryProvider = Provider<CourseSubjectRepository>(
  (ref) => DriftCourseSubjectRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(syncQueueServiceProvider),
  ),
);

final courseSubjectsProvider = StreamProvider<List<CourseSubject>>(
  (ref) {
    final activeProfileId =
        ref.watch(activeAcademicProfileProvider).valueOrNull?.id;
    return ref
        .watch(courseSubjectRepositoryProvider)
        .watchSubjects(academicProfileId: activeProfileId);
  },
);

final courseSubjectByIdProvider =
    FutureProvider.family<CourseSubject?, String>((ref, id) {
  return ref.watch(courseSubjectRepositoryProvider).findById(id);
});

final courseSubjectLessonsProvider =
    StreamProvider.family<List<CourseSubjectLesson>, String>((ref, subjectId) {
  return ref.watch(courseSubjectRepositoryProvider).watchLessons(subjectId);
});

final courseSubjectLessonByIdProvider =
    FutureProvider.family<CourseSubjectLesson?, String>((ref, id) {
  return ref.watch(courseSubjectRepositoryProvider).findLessonById(id);
});
