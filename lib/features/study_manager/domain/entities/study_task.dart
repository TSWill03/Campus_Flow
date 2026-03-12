// Signature: dev.tswicolly03

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';

part 'study_task.freezed.dart';
part 'study_task.g.dart';

@freezed
abstract class StudyTask with _$StudyTask {
  const factory StudyTask({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    required String title,
    String? description,
    String? studySubjectId,
    DateTime? dueDate,
    required StudyTaskPriority priority,
    required StudyTaskStatus status,
  }) = _StudyTask;

  factory StudyTask.fromJson(Map<String, dynamic> json) =>
      _$StudyTaskFromJson(json);
}
