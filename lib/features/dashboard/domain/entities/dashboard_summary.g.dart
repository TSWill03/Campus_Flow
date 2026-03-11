// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardSummary _$DashboardSummaryFromJson(
  Map<String, dynamic> json,
) => _DashboardSummary(
  courseCompletionPercentage: (json['courseCompletionPercentage'] as num)
      .toDouble(),
  totalSubjects: (json['totalSubjects'] as num).toInt(),
  completedSubjects: (json['completedSubjects'] as num).toInt(),
  pendingSubjects: (json['pendingSubjects'] as num).toInt(),
  completedComplementaryHours: (json['completedComplementaryHours'] as num)
      .toInt(),
  remainingComplementaryHours: (json['remainingComplementaryHours'] as num)
      .toInt(),
  completedInternshipHours: (json['completedInternshipHours'] as num).toInt(),
  remainingInternshipHours: (json['remainingInternshipHours'] as num).toInt(),
  completedExtensionHours: (json['completedExtensionHours'] as num).toInt(),
  remainingExtensionHours: (json['remainingExtensionHours'] as num).toInt(),
  totalStudySessions: (json['totalStudySessions'] as num).toInt(),
  totalStudyMinutes: (json['totalStudyMinutes'] as num).toInt(),
);

Map<String, dynamic> _$DashboardSummaryToJson(_DashboardSummary instance) =>
    <String, dynamic>{
      'courseCompletionPercentage': instance.courseCompletionPercentage,
      'totalSubjects': instance.totalSubjects,
      'completedSubjects': instance.completedSubjects,
      'pendingSubjects': instance.pendingSubjects,
      'completedComplementaryHours': instance.completedComplementaryHours,
      'remainingComplementaryHours': instance.remainingComplementaryHours,
      'completedInternshipHours': instance.completedInternshipHours,
      'remainingInternshipHours': instance.remainingInternshipHours,
      'completedExtensionHours': instance.completedExtensionHours,
      'remainingExtensionHours': instance.remainingExtensionHours,
      'totalStudySessions': instance.totalStudySessions,
      'totalStudyMinutes': instance.totalStudyMinutes,
    };
