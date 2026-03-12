// Signature: dev.tswicolly03

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';

part 'internship_record.freezed.dart';
part 'internship_record.g.dart';

@freezed
abstract class InternshipRecord with _$InternshipRecord {
  const factory InternshipRecord({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    String? academicProfileId,
    required String location,
    String? supervisor,
    required DateTime startDate,
    DateTime? endDate,
    required int totalHours,
    required int completedHours,
    required InternshipStatus status,
    String? notes,
  }) = _InternshipRecord;

  factory InternshipRecord.fromJson(Map<String, dynamic> json) =>
      _$InternshipRecordFromJson(json);
}
