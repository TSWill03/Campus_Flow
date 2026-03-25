// Signature: dev.tswicolly03

import '../../../../shared/enums/app_enums.dart';

class SubjectEquivalenceSuggestion {
  const SubjectEquivalenceSuggestion({
    required this.importedSubjectLocalId,
    required this.importedSubjectName,
    required this.existingSubjectId,
    required this.existingSubjectName,
    required this.existingProfileId,
    required this.existingProfileName,
    required this.existingStatus,
    required this.matchScore,
    required this.nameSimilarity,
    required this.syllabusSimilarity,
    required this.workloadSimilarity,
  });

  final String importedSubjectLocalId;
  final String importedSubjectName;
  final String existingSubjectId;
  final String existingSubjectName;
  final String existingProfileId;
  final String existingProfileName;
  final CourseSubjectStatus existingStatus;
  final double matchScore;
  final double nameSimilarity;
  final double syllabusSimilarity;
  final double workloadSimilarity;

  bool get isCompletedEquivalent =>
      existingStatus == CourseSubjectStatus.completed;
}
