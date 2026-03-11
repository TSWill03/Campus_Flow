// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyTopic _$StudyTopicFromJson(Map<String, dynamic> json) => _StudyTopic(
  id: json['id'] as String,
  remoteId: json['remoteId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
  isDeleted: json['isDeleted'] as bool,
  studySubjectId: json['studySubjectId'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  status: $enumDecode(_$StudyTopicStatusEnumMap, json['status']),
);

Map<String, dynamic> _$StudyTopicToJson(_StudyTopic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remoteId': instance.remoteId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'isDeleted': instance.isDeleted,
      'studySubjectId': instance.studySubjectId,
      'name': instance.name,
      'description': instance.description,
      'status': _$StudyTopicStatusEnumMap[instance.status]!,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.pendingCreate: 'pending_create',
  SyncStatus.pendingUpdate: 'pending_update',
  SyncStatus.pendingDelete: 'pending_delete',
  SyncStatus.synced: 'synced',
};

const _$StudyTopicStatusEnumMap = {
  StudyTopicStatus.notStarted: 'not_started',
  StudyTopicStatus.studying: 'studying',
  StudyTopicStatus.completed: 'completed',
};
