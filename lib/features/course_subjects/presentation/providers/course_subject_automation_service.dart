// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/sync/sync_status.dart';
import '../../../../core/utils/id_generator.dart';
import '../../domain/entities/course_subject_lesson.dart';
import '../../domain/repositories/course_subject_repository.dart';
import 'course_subjects_provider.dart';

class CourseSubjectAutomationService {
  CourseSubjectAutomationService(this._repository);

  final CourseSubjectRepository _repository;

  Future<bool> markAbsentToday({
    required String subjectId,
    double? defaultLessonHours,
  }) async {
    final now = DateTime.now();
    final existingLessons = await _repository.getAllLessons(
      subjectId: subjectId,
    );
    final alreadyRegistered = existingLessons.any(
      (lesson) => _isSameDay(lesson.lessonDate, now),
    );
    if (alreadyRegistered) {
      return false;
    }

    final lesson = CourseSubjectLesson(
      id: IdGenerator.generate(),
      createdAt: now,
      updatedAt: now,
      syncStatus: SyncStatus.pendingCreate,
      isDeleted: false,
      courseSubjectId: subjectId,
      lessonDate: now,
      lessonHours: defaultLessonHours ?? 1,
      coveredContent: 'Falta registrada',
      description: 'Ausencia marcada pelo lembrete automatico da disciplina.',
      activityDescription: null,
      assessmentDescription: null,
      assessmentDate: null,
      pdfName: null,
      pdfBytes: null,
      wasAbsent: true,
    );
    await _repository.saveLesson(lesson);
    return true;
  }

  bool _isSameDay(DateTime left, DateTime right) {
    return left.year == right.year &&
        left.month == right.month &&
        left.day == right.day;
  }
}

final courseSubjectAutomationServiceProvider =
    Provider<CourseSubjectAutomationService>(
  (ref) => CourseSubjectAutomationService(
    ref.watch(courseSubjectRepositoryProvider),
  ),
);
