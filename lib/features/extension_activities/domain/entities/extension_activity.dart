// Signature: dev.tswicolly03

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/sync/sync_status.dart';
import '../../../../shared/enums/app_enums.dart';

part 'extension_activity.freezed.dart';
part 'extension_activity.g.dart';

@freezed
abstract class ExtensionActivity with _$ExtensionActivity {
  const factory ExtensionActivity({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    String? academicProfileId,
    required String title,
    required String type,
    required DateTime date,
    required int workloadHours,
    String? notes,
    required ValidationStatus status,
  }) = _ExtensionActivity;

  factory ExtensionActivity.fromJson(Map<String, dynamic> json) =>
      _$ExtensionActivityFromJson(json);
}
