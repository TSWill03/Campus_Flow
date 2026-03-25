// Signature: dev.tswicolly03

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';

part 'course_subject.freezed.dart';
part 'course_subject.g.dart';

@freezed
abstract class CourseSubject with _$CourseSubject {
  const factory CourseSubject({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    String? academicProfileId,
    required String name,
    String? code,
    required int workloadHours,
    int? electiveHours,
    int? suggestedSemester,
    @Default(<String>[]) List<String> prerequisiteSubjectIds,
    int? scheduledWeekday,
    double? defaultLessonHours,
    required CourseSubjectType type,
    required CourseSubjectStatus status,
    String? creditSourceSubjectId,
    String? creditSourceProfileId,
    @Default(CourseSubjectCreditStatus.none)
    CourseSubjectCreditStatus creditStatus,
    double? creditMatchScore,
    String? syllabus,
    String? notes,
  }) = _CourseSubject;

  factory CourseSubject.fromJson(Map<String, dynamic> json) =>
      _$CourseSubjectFromJson(json);
}
