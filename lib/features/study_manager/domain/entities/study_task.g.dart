// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyTask _$StudyTaskFromJson(Map<String, dynamic> json) => _StudyTask(
  id: json['id'] as String,
  remoteId: json['remoteId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
  isDeleted: json['isDeleted'] as bool,
  title: json['title'] as String,
  description: json['description'] as String?,
  studySubjectId: json['studySubjectId'] as String?,
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  priority: $enumDecode(_$StudyTaskPriorityEnumMap, json['priority']),
  status: $enumDecode(_$StudyTaskStatusEnumMap, json['status']),
);

Map<String, dynamic> _$StudyTaskToJson(_StudyTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remoteId': instance.remoteId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'isDeleted': instance.isDeleted,
      'title': instance.title,
      'description': instance.description,
      'studySubjectId': instance.studySubjectId,
      'dueDate': instance.dueDate?.toIso8601String(),
      'priority': _$StudyTaskPriorityEnumMap[instance.priority]!,
      'status': _$StudyTaskStatusEnumMap[instance.status]!,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.pendingCreate: 'pending_create',
  SyncStatus.pendingUpdate: 'pending_update',
  SyncStatus.pendingDelete: 'pending_delete',
  SyncStatus.synced: 'synced',
};

const _$StudyTaskPriorityEnumMap = {
  StudyTaskPriority.low: 'low',
  StudyTaskPriority.medium: 'medium',
  StudyTaskPriority.high: 'high',
};

const _$StudyTaskStatusEnumMap = {
  StudyTaskStatus.pending: 'pending',
  StudyTaskStatus.inProgress: 'in_progress',
  StudyTaskStatus.done: 'done',
  StudyTaskStatus.canceled: 'canceled',
};
