// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CourseSubject _$CourseSubjectFromJson(Map<String, dynamic> json) =>
    _CourseSubject(
      id: json['id'] as String,
      remoteId: json['remoteId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
      isDeleted: json['isDeleted'] as bool,
      academicProfileId: json['academicProfileId'] as String?,
      name: json['name'] as String,
      code: json['code'] as String?,
      workloadHours: (json['workloadHours'] as num).toInt(),
      electiveHours: (json['electiveHours'] as num?)?.toInt(),
      suggestedSemester: (json['suggestedSemester'] as num?)?.toInt(),
      scheduledWeekday: (json['scheduledWeekday'] as num?)?.toInt(),
      defaultLessonHours: (json['defaultLessonHours'] as num?)?.toDouble(),
      type: $enumDecode(_$CourseSubjectTypeEnumMap, json['type']),
      status: $enumDecode(_$CourseSubjectStatusEnumMap, json['status']),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CourseSubjectToJson(_CourseSubject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remoteId': instance.remoteId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'isDeleted': instance.isDeleted,
      'academicProfileId': instance.academicProfileId,
      'name': instance.name,
      'code': instance.code,
      'workloadHours': instance.workloadHours,
      'electiveHours': instance.electiveHours,
      'suggestedSemester': instance.suggestedSemester,
      'scheduledWeekday': instance.scheduledWeekday,
      'defaultLessonHours': instance.defaultLessonHours,
      'type': _$CourseSubjectTypeEnumMap[instance.type]!,
      'status': _$CourseSubjectStatusEnumMap[instance.status]!,
      'notes': instance.notes,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.pendingCreate: 'pending_create',
  SyncStatus.pendingUpdate: 'pending_update',
  SyncStatus.pendingDelete: 'pending_delete',
  SyncStatus.synced: 'synced',
};

const _$CourseSubjectTypeEnumMap = {
  CourseSubjectType.mandatory: 'mandatory',
  CourseSubjectType.elective: 'elective',
  CourseSubjectType.internship: 'internship',
  CourseSubjectType.extension: 'extension',
  CourseSubjectType.thesis: 'thesis',
};

const _$CourseSubjectStatusEnumMap = {
  CourseSubjectStatus.notStarted: 'not_started',
  CourseSubjectStatus.inProgress: 'in_progress',
  CourseSubjectStatus.completed: 'completed',
  CourseSubjectStatus.failed: 'failed',
  CourseSubjectStatus.dropped: 'dropped',
};
