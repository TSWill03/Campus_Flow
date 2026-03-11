// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internship_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InternshipRecord _$InternshipRecordFromJson(Map<String, dynamic> json) =>
    _InternshipRecord(
      id: json['id'] as String,
      remoteId: json['remoteId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
      isDeleted: json['isDeleted'] as bool,
      academicProfileId: json['academicProfileId'] as String?,
      location: json['location'] as String,
      supervisor: json['supervisor'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      totalHours: (json['totalHours'] as num).toInt(),
      completedHours: (json['completedHours'] as num).toInt(),
      status: $enumDecode(_$InternshipStatusEnumMap, json['status']),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$InternshipRecordToJson(_InternshipRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remoteId': instance.remoteId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'isDeleted': instance.isDeleted,
      'academicProfileId': instance.academicProfileId,
      'location': instance.location,
      'supervisor': instance.supervisor,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'totalHours': instance.totalHours,
      'completedHours': instance.completedHours,
      'status': _$InternshipStatusEnumMap[instance.status]!,
      'notes': instance.notes,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.pendingCreate: 'pending_create',
  SyncStatus.pendingUpdate: 'pending_update',
  SyncStatus.pendingDelete: 'pending_delete',
  SyncStatus.synced: 'synced',
};

const _$InternshipStatusEnumMap = {
  InternshipStatus.planned: 'planned',
  InternshipStatus.inProgress: 'in_progress',
  InternshipStatus.completed: 'completed',
  InternshipStatus.interrupted: 'interrupted',
};
