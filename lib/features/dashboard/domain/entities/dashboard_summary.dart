import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_summary.freezed.dart';
part 'dashboard_summary.g.dart';

@freezed
abstract class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    required double courseCompletionPercentage,
    required int totalSubjects,
    required int completedSubjects,
    required int pendingSubjects,
    required int completedComplementaryHours,
    required int remainingComplementaryHours,
    required int completedInternshipHours,
    required int remainingInternshipHours,
    required int completedExtensionHours,
    required int remainingExtensionHours,
    required int totalStudySessions,
    required int totalStudyMinutes,
  }) = _DashboardSummary;

  factory DashboardSummary.initial() => const DashboardSummary(
        courseCompletionPercentage: 0,
        totalSubjects: 0,
        completedSubjects: 0,
        pendingSubjects: 0,
        completedComplementaryHours: 0,
        remainingComplementaryHours: 0,
        completedInternshipHours: 0,
        remainingInternshipHours: 0,
        completedExtensionHours: 0,
        remainingExtensionHours: 0,
        totalStudySessions: 0,
        totalStudyMinutes: 0,
      );

  factory DashboardSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryFromJson(json);
}
