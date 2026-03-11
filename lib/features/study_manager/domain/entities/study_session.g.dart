// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudySession _$StudySessionFromJson(Map<String, dynamic> json) =>
    _StudySession(
      id: json['id'] as String,
      remoteId: json['remoteId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
      isDeleted: json['isDeleted'] as bool,
      studySubjectId: json['studySubjectId'] as String?,
      studyTopicId: json['studyTopicId'] as String?,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: DateTime.parse(json['endedAt'] as String),
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$StudySessionToJson(_StudySession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remoteId': instance.remoteId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'isDeleted': instance.isDeleted,
      'studySubjectId': instance.studySubjectId,
      'studyTopicId': instance.studyTopicId,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt.toIso8601String(),
      'durationMinutes': instance.durationMinutes,
      'notes': instance.notes,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.pendingCreate: 'pending_create',
  SyncStatus.pendingUpdate: 'pending_update',
  SyncStatus.pendingDelete: 'pending_delete',
  SyncStatus.synced: 'synced',
};
