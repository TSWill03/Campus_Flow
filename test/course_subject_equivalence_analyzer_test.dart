// Signature: dev.tswicolly03

import 'package:flutter_test/flutter_test.dart';

import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/academic_profile/data/services/course_subject_equivalence_analyzer.dart';
import 'package:campus_flow/features/academic_profile/domain/entities/academic_profile.dart';
import 'package:campus_flow/features/academic_profile/domain/entities/curriculum_import_subject_draft.dart';
import 'package:campus_flow/features/course_subjects/domain/entities/course_subject.dart';
import 'package:campus_flow/shared/enums/app_enums.dart';

void main() {
  group('CourseSubjectEquivalenceAnalyzer', () {
    test('suggests credit when the name matches exactly', () {
      final analyzer = const CourseSubjectEquivalenceAnalyzer();
      final suggestions = analyzer.analyze(
        importedSubjects: const [
          CurriculumImportSubjectDraft(
            localId: 'imported-1',
            name: 'Algoritmos e Programacao de Computadores',
            workloadHours: 72,
            type: CourseSubjectType.mandatory,
          ),
        ],
        existingProfiles: [_profile('profile-a', 'Primeira graduacao')],
        existingSubjects: [
          _subject(
            id: 'subject-a',
            profileId: 'profile-a',
            name: 'Algoritmos e Programacao de Computadores',
            status: CourseSubjectStatus.completed,
          ),
        ],
      );

      final importedSuggestions = suggestions['imported-1'];
      expect(importedSuggestions, isNotNull);
      expect(importedSuggestions, isNotEmpty);
      expect(importedSuggestions!.first.existingSubjectId, 'subject-a');
      expect(importedSuggestions.first.isCompletedEquivalent, isTrue);
      expect(importedSuggestions.first.nameSimilarity, 1);
    });

    test('suggests credit when the syllabus similarity is above 80 percent', () {
      final analyzer = const CourseSubjectEquivalenceAnalyzer();
      final suggestions = analyzer.analyze(
        importedSubjects: const [
          CurriculumImportSubjectDraft(
            localId: 'imported-1',
            name: 'Fundamentos de Programacao',
            workloadHours: 72,
            type: CourseSubjectType.mandatory,
            syllabus:
                'Logica de programacao constantes tipos de dados variaveis expressoes aritmeticas estruturas de decisao estruturas de controle vetores matrizes funcoes desenvolvimento de algoritmos linguagem de programacao ambiente de desenvolvimento pequenos programas',
          ),
        ],
        existingProfiles: [_profile('profile-a', 'Primeira graduacao')],
        existingSubjects: [
          _subject(
            id: 'subject-a',
            profileId: 'profile-a',
            name: 'Algoritmos e Programacao de Computadores',
            status: CourseSubjectStatus.completed,
            syllabus:
                'Logica de programacao constantes tipos de dados variaveis expressoes aritmeticas e logicas estruturas de decisao estruturas de controle vetores arrays matrizes funcoes desenvolvimento de algoritmos transcricao de algoritmos linguagem de programacao sintaxe e semantica ambiente de desenvolvimento desenvolvimento de pequenos programas',
          ),
        ],
      );

      final importedSuggestions = suggestions['imported-1'];
      expect(importedSuggestions, isNotNull);
      expect(importedSuggestions, isNotEmpty);
      expect(
        importedSuggestions!.first.syllabusSimilarity,
        greaterThanOrEqualTo(0.8),
      );
    });
  });
}

AcademicProfile _profile(String id, String profileName) {
  return AcademicProfile(
    id: id,
    remoteId: null,
    createdAt: DateTime(2026, 3, 20),
    updatedAt: DateTime(2026, 3, 20),
    syncStatus: SyncStatus.synced,
    isDeleted: false,
    profileName: profileName,
    courseName: profileName,
    institution: 'CampusFlow',
    schoolName: null,
    campus: null,
    degreeLabel: null,
    isActive: false,
    totalCourseHours: 3200,
    semesterCount: 8,
    requiredComplementaryHours: 0,
    requiredInternshipHours: 0,
    requiredExtensionHours: 0,
  );
}

CourseSubject _subject({
  required String id,
  required String profileId,
  required String name,
  required CourseSubjectStatus status,
  String? syllabus,
}) {
  return CourseSubject(
    id: id,
    remoteId: null,
    createdAt: DateTime(2026, 3, 20),
    updatedAt: DateTime(2026, 3, 20),
    syncStatus: SyncStatus.synced,
    isDeleted: false,
    academicProfileId: profileId,
    name: name,
    code: null,
    workloadHours: 72,
    electiveHours: null,
    suggestedSemester: 1,
    prerequisiteSubjectIds: const <String>[],
    scheduledWeekday: null,
    defaultLessonHours: null,
    type: CourseSubjectType.mandatory,
    status: status,
    syllabus: syllabus,
    notes: null,
  );
}
