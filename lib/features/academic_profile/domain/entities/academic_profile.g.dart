// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AcademicProfile _$AcademicProfileFromJson(Map<String, dynamic> json) =>
    _AcademicProfile(
      id: json['id'] as String,
      remoteId: json['remoteId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
      isDeleted: json['isDeleted'] as bool,
      profileName: json['profileName'] as String,
      courseName: json['courseName'] as String,
      institution: json['institution'] as String,
      schoolName: json['schoolName'] as String?,
      campus: json['campus'] as String?,
      degreeLabel: json['degreeLabel'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      totalCourseHours: (json['totalCourseHours'] as num).toInt(),
      semesterCount: (json['semesterCount'] as num).toInt(),
      requiredComplementaryHours: (json['requiredComplementaryHours'] as num)
          .toInt(),
      requiredInternshipHours: (json['requiredInternshipHours'] as num).toInt(),
      requiredExtensionHours: (json['requiredExtensionHours'] as num).toInt(),
    );

Map<String, dynamic> _$AcademicProfileToJson(_AcademicProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remoteId': instance.remoteId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'isDeleted': instance.isDeleted,
      'profileName': instance.profileName,
      'courseName': instance.courseName,
      'institution': instance.institution,
      'schoolName': instance.schoolName,
      'campus': instance.campus,
      'degreeLabel': instance.degreeLabel,
      'isActive': instance.isActive,
      'totalCourseHours': instance.totalCourseHours,
      'semesterCount': instance.semesterCount,
      'requiredComplementaryHours': instance.requiredComplementaryHours,
      'requiredInternshipHours': instance.requiredInternshipHours,
      'requiredExtensionHours': instance.requiredExtensionHours,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.pendingCreate: 'pending_create',
  SyncStatus.pendingUpdate: 'pending_update',
  SyncStatus.pendingDelete: 'pending_delete',
  SyncStatus.synced: 'synced',
};
