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
      prerequisiteSubjectIds:
          (json['prerequisiteSubjectIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      scheduledWeekday: (json['scheduledWeekday'] as num?)?.toInt(),
      defaultLessonHours: (json['defaultLessonHours'] as num?)?.toDouble(),
      type: $enumDecode(_$CourseSubjectTypeEnumMap, json['type']),
      status: $enumDecode(_$CourseSubjectStatusEnumMap, json['status']),
      creditSourceSubjectId: json['creditSourceSubjectId'] as String?,
      creditSourceProfileId: json['creditSourceProfileId'] as String?,
      creditStatus:
          $enumDecodeNullable(
            _$CourseSubjectCreditStatusEnumMap,
            json['creditStatus'],
          ) ??
          CourseSubjectCreditStatus.none,
      creditMatchScore: (json['creditMatchScore'] as num?)?.toDouble(),
      syllabus: json['syllabus'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CourseSubjectToJson(
  _CourseSubject instance,
) => <String, dynamic>{
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
  'prerequisiteSubjectIds': instance.prerequisiteSubjectIds,
  'scheduledWeekday': instance.scheduledWeekday,
  'defaultLessonHours': instance.defaultLessonHours,
  'type': _$CourseSubjectTypeEnumMap[instance.type]!,
  'status': _$CourseSubjectStatusEnumMap[instance.status]!,
  'creditSourceSubjectId': instance.creditSourceSubjectId,
  'creditSourceProfileId': instance.creditSourceProfileId,
  'creditStatus': _$CourseSubjectCreditStatusEnumMap[instance.creditStatus]!,
  'creditMatchScore': instance.creditMatchScore,
  'syllabus': instance.syllabus,
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

const _$CourseSubjectCreditStatusEnumMap = {
  CourseSubjectCreditStatus.none: 'none',
  CourseSubjectCreditStatus.suggested: 'suggested',
  CourseSubjectCreditStatus.requested: 'requested',
  CourseSubjectCreditStatus.approved: 'approved',
  CourseSubjectCreditStatus.rejected: 'rejected',
};
