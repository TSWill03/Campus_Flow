import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';

part 'study_topic.freezed.dart';
part 'study_topic.g.dart';

@freezed
abstract class StudyTopic with _$StudyTopic {
  const factory StudyTopic({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    required String studySubjectId,
    required String name,
    String? description,
    required StudyTopicStatus status,
  }) = _StudyTopic;

  factory StudyTopic.fromJson(Map<String, dynamic> json) =>
      _$StudyTopicFromJson(json);
}
