// Signature: dev.tswicolly03

import '../../../../shared/enums/app_enums.dart';

class CurriculumImportSubjectDraft {
  const CurriculumImportSubjectDraft({
    required this.localId,
    required this.name,
    required this.workloadHours,
    required this.type,
    this.prerequisiteLocalIds = const <String>[],
    this.code,
    this.suggestedSemester,
    this.syllabus,
    this.creditSourceSubjectId,
    this.creditSourceProfileId,
    this.creditStatus = CourseSubjectCreditStatus.none,
    this.creditMatchScore,
    this.notes,
  });

  final String localId;
  final String name;
  final String? code;
  final int workloadHours;
  final int? suggestedSemester;
  final CourseSubjectType type;
  final List<String> prerequisiteLocalIds;
  final String? syllabus;
  final String? creditSourceSubjectId;
  final String? creditSourceProfileId;
  final CourseSubjectCreditStatus creditStatus;
  final double? creditMatchScore;
  final String? notes;

  CurriculumImportSubjectDraft copyWith({
    String? localId,
    String? name,
    Object? code = _sentinel,
    int? workloadHours,
    Object? suggestedSemester = _sentinel,
    CourseSubjectType? type,
    List<String>? prerequisiteLocalIds,
    Object? syllabus = _sentinel,
    Object? creditSourceSubjectId = _sentinel,
    Object? creditSourceProfileId = _sentinel,
    CourseSubjectCreditStatus? creditStatus,
    Object? creditMatchScore = _sentinel,
    Object? notes = _sentinel,
  }) {
    return CurriculumImportSubjectDraft(
      localId: localId ?? this.localId,
      name: name ?? this.name,
      code: identical(code, _sentinel) ? this.code : code as String?,
      workloadHours: workloadHours ?? this.workloadHours,
      suggestedSemester: identical(suggestedSemester, _sentinel)
          ? this.suggestedSemester
          : suggestedSemester as int?,
      type: type ?? this.type,
      prerequisiteLocalIds: prerequisiteLocalIds ?? this.prerequisiteLocalIds,
      syllabus: identical(syllabus, _sentinel)
          ? this.syllabus
          : syllabus as String?,
      creditSourceSubjectId:
          identical(creditSourceSubjectId, _sentinel)
              ? this.creditSourceSubjectId
              : creditSourceSubjectId as String?,
      creditSourceProfileId:
          identical(creditSourceProfileId, _sentinel)
              ? this.creditSourceProfileId
              : creditSourceProfileId as String?,
      creditStatus: creditStatus ?? this.creditStatus,
      creditMatchScore:
          identical(creditMatchScore, _sentinel)
              ? this.creditMatchScore
              : creditMatchScore as double?,
      notes: identical(notes, _sentinel) ? this.notes : notes as String?,
    );
  }
}

const Object _sentinel = Object();
