import 'package:freezed_annotation/freezed_annotation.dart';

import '../attachments/stored_attachment.dart';
import '../../features/academic_profile/domain/entities/academic_profile.dart';
import '../../features/complementary_hours/domain/entities/complementary_activity.dart';
import '../../features/course_subjects/domain/entities/course_subject.dart';
import '../../features/course_subjects/domain/entities/course_subject_lesson.dart';
import '../../features/extension_activities/domain/entities/extension_activity.dart';
import '../../features/internships/domain/entities/internship_record.dart';
import '../../features/study_manager/domain/entities/study_session.dart';
import '../../features/study_manager/domain/entities/study_subject.dart';
import '../../features/study_manager/domain/entities/study_task.dart';
import '../../features/study_manager/domain/entities/study_topic.dart';

part 'backup_bundle.freezed.dart';
part 'backup_bundle.g.dart';

@freezed
abstract class BackupBundle with _$BackupBundle {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory BackupBundle({
    required int schemaVersion,
    required DateTime exportedAt,
    required List<AcademicProfile> academicProfiles,
    required List<CourseSubject> courseSubjects,
    required List<CourseSubjectLesson> courseSubjectLessons,
    required List<StoredAttachment> attachments,
    required List<ComplementaryActivity> complementaryActivities,
    required List<InternshipRecord> internships,
    required List<ExtensionActivity> extensionActivities,
    required List<StudySubject> studySubjects,
    required List<StudyTopic> studyTopics,
    required List<StudyTask> studyTasks,
    required List<StudySession> studySessions,
  }) = _BackupBundle;

  factory BackupBundle.fromJson(Map<String, dynamic> json) =>
      _$BackupBundleFromJson(json);
}
