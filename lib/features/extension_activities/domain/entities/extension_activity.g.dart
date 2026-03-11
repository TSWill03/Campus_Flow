// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extension_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExtensionActivity _$ExtensionActivityFromJson(Map<String, dynamic> json) =>
    _ExtensionActivity(
      id: json['id'] as String,
      remoteId: json['remoteId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
      isDeleted: json['isDeleted'] as bool,
      academicProfileId: json['academicProfileId'] as String?,
      title: json['title'] as String,
      type: json['type'] as String,
      date: DateTime.parse(json['date'] as String),
      workloadHours: (json['workloadHours'] as num).toInt(),
      notes: json['notes'] as String?,
      status: $enumDecode(_$ValidationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$ExtensionActivityToJson(_ExtensionActivity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remoteId': instance.remoteId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'isDeleted': instance.isDeleted,
      'academicProfileId': instance.academicProfileId,
      'title': instance.title,
      'type': instance.type,
      'date': instance.date.toIso8601String(),
      'workloadHours': instance.workloadHours,
      'notes': instance.notes,
      'status': _$ValidationStatusEnumMap[instance.status]!,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.pendingCreate: 'pending_create',
  SyncStatus.pendingUpdate: 'pending_update',
  SyncStatus.pendingDelete: 'pending_delete',
  SyncStatus.synced: 'synced',
};

const _$ValidationStatusEnumMap = {
  ValidationStatus.pending: 'pending',
  ValidationStatus.submitted: 'submitted',
  ValidationStatus.approved: 'approved',
  ValidationStatus.rejected: 'rejected',
};
