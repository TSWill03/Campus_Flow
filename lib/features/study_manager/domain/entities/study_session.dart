// Signature: dev.tswicolly03

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/sync/sync_status.dart';

part 'study_session.freezed.dart';
part 'study_session.g.dart';

@freezed
abstract class StudySession with _$StudySession {
  const factory StudySession({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    String? studySubjectId,
    String? studyTopicId,
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationMinutes,
    String? notes,
  }) = _StudySession;

  factory StudySession.fromJson(Map<String, dynamic> json) =>
      _$StudySessionFromJson(json);
}
