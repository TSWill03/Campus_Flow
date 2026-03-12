// Signature: dev.tswicolly03

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';

part 'complementary_activity.freezed.dart';
part 'complementary_activity.g.dart';

@freezed
abstract class ComplementaryActivity with _$ComplementaryActivity {
  const factory ComplementaryActivity({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    String? academicProfileId,
    required String title,
    required String category,
    required DateTime date,
    DateTime? endDate,
    required int workloadHours,
    String? notes,
    required ValidationStatus status,
  }) = _ComplementaryActivity;

  factory ComplementaryActivity.fromJson(Map<String, dynamic> json) =>
      _$ComplementaryActivityFromJson(json);
}
