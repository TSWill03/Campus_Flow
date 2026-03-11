import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/sync/sync_status.dart';

part 'course_subject_lesson.freezed.dart';
part 'course_subject_lesson.g.dart';

@freezed
abstract class CourseSubjectLesson with _$CourseSubjectLesson {
  const factory CourseSubjectLesson({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    required String courseSubjectId,
    required DateTime lessonDate,
    required double lessonHours,
    required String coveredContent,
    String? description,
    String? activityDescription,
    String? assessmentDescription,
    DateTime? assessmentDate,
    String? pdfName,
    List<int>? pdfBytes,
  }) = _CourseSubjectLesson;

  factory CourseSubjectLesson.fromJson(Map<String, dynamic> json) =>
      _$CourseSubjectLessonFromJson(json);
}
