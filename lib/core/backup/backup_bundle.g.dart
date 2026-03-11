// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_bundle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupBundle _$BackupBundleFromJson(
  Map<String, dynamic> json,
) => _BackupBundle(
  schemaVersion: (json['schemaVersion'] as num).toInt(),
  exportedAt: DateTime.parse(json['exportedAt'] as String),
  academicProfiles: (json['academicProfiles'] as List<dynamic>)
      .map((e) => AcademicProfile.fromJson(e as Map<String, dynamic>))
      .toList(),
  courseSubjects: (json['courseSubjects'] as List<dynamic>)
      .map((e) => CourseSubject.fromJson(e as Map<String, dynamic>))
      .toList(),
  courseSubjectLessons: (json['courseSubjectLessons'] as List<dynamic>)
      .map((e) => CourseSubjectLesson.fromJson(e as Map<String, dynamic>))
      .toList(),
  attachments: (json['attachments'] as List<dynamic>)
      .map((e) => StoredAttachment.fromJson(e as Map<String, dynamic>))
      .toList(),
  complementaryActivities: (json['complementaryActivities'] as List<dynamic>)
      .map((e) => ComplementaryActivity.fromJson(e as Map<String, dynamic>))
      .toList(),
  internships: (json['internships'] as List<dynamic>)
      .map((e) => InternshipRecord.fromJson(e as Map<String, dynamic>))
      .toList(),
  extensionActivities: (json['extensionActivities'] as List<dynamic>)
      .map((e) => ExtensionActivity.fromJson(e as Map<String, dynamic>))
      .toList(),
  studySubjects: (json['studySubjects'] as List<dynamic>)
      .map((e) => StudySubject.fromJson(e as Map<String, dynamic>))
      .toList(),
  studyTopics: (json['studyTopics'] as List<dynamic>)
      .map((e) => StudyTopic.fromJson(e as Map<String, dynamic>))
      .toList(),
  studyTasks: (json['studyTasks'] as List<dynamic>)
      .map((e) => StudyTask.fromJson(e as Map<String, dynamic>))
      .toList(),
  studySessions: (json['studySessions'] as List<dynamic>)
      .map((e) => StudySession.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BackupBundleToJson(
  _BackupBundle instance,
) => <String, dynamic>{
  'schemaVersion': instance.schemaVersion,
  'exportedAt': instance.exportedAt.toIso8601String(),
  'academicProfiles': instance.academicProfiles.map((e) => e.toJson()).toList(),
  'courseSubjects': instance.courseSubjects.map((e) => e.toJson()).toList(),
  'courseSubjectLessons': instance.courseSubjectLessons
      .map((e) => e.toJson())
      .toList(),
  'attachments': instance.attachments.map((e) => e.toJson()).toList(),
  'complementaryActivities': instance.complementaryActivities
      .map((e) => e.toJson())
      .toList(),
  'internships': instance.internships.map((e) => e.toJson()).toList(),
  'extensionActivities': instance.extensionActivities
      .map((e) => e.toJson())
      .toList(),
  'studySubjects': instance.studySubjects.map((e) => e.toJson()).toList(),
  'studyTopics': instance.studyTopics.map((e) => e.toJson()).toList(),
  'studyTasks': instance.studyTasks.map((e) => e.toJson()).toList(),
  'studySessions': instance.studySessions.map((e) => e.toJson()).toList(),
};
