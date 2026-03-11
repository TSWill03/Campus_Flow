// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_subject_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseSubjectLesson _$CourseSubjectLessonFromJson(Map<String, dynamic> json) =>
    _CourseSubjectLesson(
      id: json['id'] as String,
      remoteId: json['remoteId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
      isDeleted: json['isDeleted'] as bool,
      courseSubjectId: json['courseSubjectId'] as String,
      lessonDate: DateTime.parse(json['lessonDate'] as String),
      lessonHours: (json['lessonHours'] as num).toDouble(),
      coveredContent: json['coveredContent'] as String,
      description: json['description'] as String?,
      activityDescription: json['activityDescription'] as String?,
      assessmentDescription: json['assessmentDescription'] as String?,
      assessmentDate: json['assessmentDate'] == null
          ? null
          : DateTime.parse(json['assessmentDate'] as String),
      pdfName: json['pdfName'] as String?,
      pdfBytes: (json['pdfBytes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CourseSubjectLessonToJson(
  _CourseSubjectLesson instance,
) => <String, dynamic>{
  'id': instance.id,
  'remoteId': instance.remoteId,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
  'isDeleted': instance.isDeleted,
  'courseSubjectId': instance.courseSubjectId,
  'lessonDate': instance.lessonDate.toIso8601String(),
  'lessonHours': instance.lessonHours,
  'coveredContent': instance.coveredContent,
  'description': instance.description,
  'activityDescription': instance.activityDescription,
  'assessmentDescription': instance.assessmentDescription,
  'assessmentDate': instance.assessmentDate?.toIso8601String(),
  'pdfName': instance.pdfName,
  'pdfBytes': instance.pdfBytes,
};

const _$SyncStatusEnumMap = {
  SyncStatus.pendingCreate: 'pending_create',
  SyncStatus.pendingUpdate: 'pending_update',
  SyncStatus.pendingDelete: 'pending_delete',
  SyncStatus.synced: 'synced',
};
