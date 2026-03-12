// Signature: dev.tswicolly03

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/sync/sync_status.dart';

part 'academic_profile.freezed.dart';
part 'academic_profile.g.dart';

@freezed
abstract class AcademicProfile with _$AcademicProfile {
  const factory AcademicProfile({
    required String id,
    String? remoteId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required SyncStatus syncStatus,
    required bool isDeleted,
    required String profileName,
    required String courseName,
    required String institution,
    String? schoolName,
    String? campus,
    String? degreeLabel,
    @Default(false) bool isActive,
    required int totalCourseHours,
    required int semesterCount,
    required int requiredComplementaryHours,
    required int requiredInternshipHours,
    required int requiredExtensionHours,
  }) = _AcademicProfile;

  factory AcademicProfile.fromJson(Map<String, dynamic> json) =>
      _$AcademicProfileFromJson(json);
}
