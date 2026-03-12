// Signature: dev.tswicolly03

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/sync/sync_status.dart';

part 'study_subject.freezed.dart';
part 'study_subject.g.dart';

@freezed
abstract class StudySubject with _$StudySubject {
  const factory StudySubject({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    required String name,
    int? colorValue,
    String? description,
  }) = _StudySubject;

  factory StudySubject.fromJson(Map<String, dynamic> json) =>
      _$StudySubjectFromJson(json);
}
