// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoredAttachment _$StoredAttachmentFromJson(Map<String, dynamic> json) =>
    _StoredAttachment(
      id: json['id'] as String,
      remoteId: json['remoteId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: $enumDecode(_$SyncStatusEnumMap, json['syncStatus']),
      isDeleted: json['isDeleted'] as bool,
      ownerType: $enumDecode(_$AttachmentOwnerTypeEnumMap, json['ownerType']),
      ownerId: json['ownerId'] as String,
      fileName: json['fileName'] as String,
      bytes: (json['bytes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      mimeType: json['mimeType'] as String?,
      category: $enumDecode(_$AttachmentCategoryEnumMap, json['category']),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$StoredAttachmentToJson(_StoredAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'remoteId': instance.remoteId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': _$SyncStatusEnumMap[instance.syncStatus]!,
      'isDeleted': instance.isDeleted,
      'ownerType': _$AttachmentOwnerTypeEnumMap[instance.ownerType]!,
      'ownerId': instance.ownerId,
      'fileName': instance.fileName,
      'bytes': instance.bytes,
      'mimeType': instance.mimeType,
      'category': _$AttachmentCategoryEnumMap[instance.category]!,
      'dueDate': instance.dueDate?.toIso8601String(),
      'isCompleted': instance.isCompleted,
    };

const _$SyncStatusEnumMap = {
  SyncStatus.pendingCreate: 'pending_create',
  SyncStatus.pendingUpdate: 'pending_update',
  SyncStatus.pendingDelete: 'pending_delete',
  SyncStatus.synced: 'synced',
};

const _$AttachmentOwnerTypeEnumMap = {
  AttachmentOwnerType.courseSubjectLesson: 'courseSubjectLesson',
  AttachmentOwnerType.complementaryActivity: 'complementaryActivity',
  AttachmentOwnerType.internshipRecord: 'internshipRecord',
};

const _$AttachmentCategoryEnumMap = {
  AttachmentCategory.lessonMaterial: 'lessonMaterial',
  AttachmentCategory.activity: 'activity',
  AttachmentCategory.slide: 'slide',
  AttachmentCategory.certificate: 'certificate',
  AttachmentCategory.document: 'document',
  AttachmentCategory.archive: 'archive',
  AttachmentCategory.other: 'other',
};
