// Signature: dev.tswicolly03

import 'curriculum_import_subject_draft.dart';

class CurriculumImportPreview {
  const CurriculumImportPreview({
    required this.profileName,
    required this.courseName,
    required this.institution,
    required this.totalCourseHours,
    required this.semesterCount,
    required this.requiredComplementaryHours,
    required this.requiredInternshipHours,
    required this.requiredExtensionHours,
    required this.subjects,
    required this.notes,
    this.schoolName,
    this.campus,
    this.degreeLabel,
    this.makeActive = true,
  });

  final String profileName;
  final String courseName;
  final String institution;
  final String? schoolName;
  final String? campus;
  final String? degreeLabel;
  final int totalCourseHours;
  final int semesterCount;
  final int requiredComplementaryHours;
  final int requiredInternshipHours;
  final int requiredExtensionHours;
  final List<CurriculumImportSubjectDraft> subjects;
  final List<String> notes;
  final bool makeActive;

  CurriculumImportPreview copyWith({
    String? profileName,
    String? courseName,
    String? institution,
    Object? schoolName = _sentinel,
    Object? campus = _sentinel,
    Object? degreeLabel = _sentinel,
    int? totalCourseHours,
    int? semesterCount,
    int? requiredComplementaryHours,
    int? requiredInternshipHours,
    int? requiredExtensionHours,
    List<CurriculumImportSubjectDraft>? subjects,
    List<String>? notes,
    bool? makeActive,
  }) {
    return CurriculumImportPreview(
      profileName: profileName ?? this.profileName,
      courseName: courseName ?? this.courseName,
      institution: institution ?? this.institution,
      schoolName: identical(schoolName, _sentinel)
          ? this.schoolName
          : schoolName as String?,
      campus: identical(campus, _sentinel) ? this.campus : campus as String?,
      degreeLabel: identical(degreeLabel, _sentinel)
          ? this.degreeLabel
          : degreeLabel as String?,
      totalCourseHours: totalCourseHours ?? this.totalCourseHours,
      semesterCount: semesterCount ?? this.semesterCount,
      requiredComplementaryHours:
          requiredComplementaryHours ?? this.requiredComplementaryHours,
      requiredInternshipHours:
          requiredInternshipHours ?? this.requiredInternshipHours,
      requiredExtensionHours:
          requiredExtensionHours ?? this.requiredExtensionHours,
      subjects: subjects ?? this.subjects,
      notes: notes ?? this.notes,
      makeActive: makeActive ?? this.makeActive,
    );
  }
}

const Object _sentinel = Object();
