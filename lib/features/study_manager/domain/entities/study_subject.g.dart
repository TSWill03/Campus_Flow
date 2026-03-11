// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudySubject _$StudySubjectFromJson(Map<String, dynamic> json) =>
    _StudySubject(
      id: json['id'] as String,
      remoteId: json['remoteId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
      isDeleted: json['isDeleted'] as bool,
      name: json['name'] as String,
      colorValue: (json['colorValue'] as num?)?.toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$StudySubjectToJson(_StudySubject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remoteId': instance.remoteId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'isDeleted': instance.isDeleted,
      'name': instance.name,
      'colorValue': instance.colorValue,
      'description': instance.description,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.pendingCreate: 'pending_create',
  SyncStatus.pendingUpdate: 'pending_update',
  SyncStatus.pendingDelete: 'pending_delete',
  SyncStatus.synced: 'synced',
};
