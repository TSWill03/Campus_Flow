// Signature: dev.tswicolly03

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:campus_flow/core/database/app_database.dart';
import 'package:campus_flow/core/database/database_providers.dart';
import 'package:campus_flow/core/sync/sync_status.dart';
import 'package:campus_flow/features/academic_profile/domain/entities/academic_profile.dart';
import 'package:campus_flow/features/academic_profile/domain/entities/curriculum_import_preview.dart';
import 'package:campus_flow/features/academic_profile/domain/entities/curriculum_import_subject_draft.dart';
import 'package:campus_flow/features/academic_profile/presentation/providers/academic_profile_provider.dart';
import 'package:campus_flow/features/academic_profile/presentation/providers/curriculum_import_controller.dart';
import 'package:campus_flow/features/course_subjects/domain/entities/course_subject.dart';
import 'package:campus_flow/features/course_subjects/presentation/providers/course_subjects_provider.dart';
import 'package:campus_flow/shared/enums/app_enums.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CurriculumImportController', () {
    test(
      'keeps prerequisite links when creating subjects in a new profile',
      () async {
        final context = await _buildTestContext();
        addTearDown(context.dispose);

        final success = await context.container
            .read(curriculumImportControllerProvider.notifier)
            .importCurriculum(_samplePreview());

        final subjects = await context.container
            .read(courseSubjectRepositoryProvider)
            .getAllSubjects();

        expect(success, isTrue);
        expect(subjects, hasLength(2));

        final algorithms = subjects.firstWhere(
          (subject) =>
              subject.name == 'Algoritmos e Programacao de Computadores',
        );
        final dataStructures = subjects.firstWhere(
          (subject) => subject.name == 'Estruturas de Dados I',
        );

        expect(dataStructures.prerequisiteSubjectIds, contains(algorithms.id));
      },
    );

    test(
      'updates an existing profile without duplicating matched subjects',
      () async {
        final context = await _buildTestContext();
        addTearDown(context.dispose);

        final existingProfile = AcademicProfile(
          id: 'profile-1',
          remoteId: null,
          createdAt: DateTime(2026, 3, 1),
          updatedAt: DateTime(2026, 3, 1, 12),
          syncStatus: SyncStatus.synced,
          isDeleted: false,
          profileName: 'BCC antigo',
          courseName: 'Ciencia da Computacao',
          institution: 'Instituto Federal',
          schoolName: 'Campus Morrinhos',
          campus: 'Morrinhos',
          degreeLabel: 'Bacharelado',
          isActive: true,
          totalCourseHours: 3000,
          semesterCount: 8,
          requiredComplementaryHours: 80,
          requiredInternshipHours: 0,
          requiredExtensionHours: 200,
        );
        await context.container
            .read(academicProfileRepositoryProvider)
            .saveProfile(existingProfile);

        final existingSubject = CourseSubject(
          id: 'subject-1',
          remoteId: null,
          createdAt: DateTime(2026, 3, 1),
          updatedAt: DateTime(2026, 3, 1, 12),
          syncStatus: SyncStatus.synced,
          isDeleted: false,
          academicProfileId: existingProfile.id,
          name: 'Algoritmos e Programacao de Computadores',
          code: null,
          workloadHours: 60,
          electiveHours: null,
          suggestedSemester: 1,
          prerequisiteSubjectIds: const <String>[],
          scheduledWeekday: 1,
          defaultLessonHours: 2,
          type: CourseSubjectType.mandatory,
          status: CourseSubjectStatus.inProgress,
          notes: 'Disciplina ja existente',
        );
        await context.container
            .read(courseSubjectRepositoryProvider)
            .saveSubject(existingSubject);

        final success = await context.container
            .read(curriculumImportControllerProvider.notifier)
            .importCurriculum(
              _samplePreview(),
              targetProfileId: existingProfile.id,
            );

        final updatedProfile = await context.container
            .read(academicProfileRepositoryProvider)
            .findById(existingProfile.id);
        final subjects = await context.container
            .read(courseSubjectRepositoryProvider)
            .getAllSubjects(academicProfileId: existingProfile.id);

        expect(success, isTrue);
        expect(subjects, hasLength(2));
        expect(updatedProfile?.profileName, 'BCC');
        expect(updatedProfile?.totalCourseHours, 3200);

        final algorithms = subjects.firstWhere(
          (subject) =>
              subject.name == 'Algoritmos e Programacao de Computadores',
        );
        final dataStructures = subjects.firstWhere(
          (subject) => subject.name == 'Estruturas de Dados I',
        );

        expect(algorithms.id, existingSubject.id);
        expect(algorithms.workloadHours, 72);
        expect(algorithms.status, CourseSubjectStatus.inProgress);
        expect(algorithms.notes, 'Disciplina ja existente');
        expect(dataStructures.prerequisiteSubjectIds, contains(algorithms.id));
      },
    );

    test(
      'removes old subjects that are missing from the new PPC when requested',
      () async {
        final context = await _buildTestContext();
        addTearDown(context.dispose);

        final existingProfile = AcademicProfile(
          id: 'profile-1',
          remoteId: null,
          createdAt: DateTime(2026, 3, 1),
          updatedAt: DateTime(2026, 3, 1, 12),
          syncStatus: SyncStatus.synced,
          isDeleted: false,
          profileName: 'BCC antigo',
          courseName: 'Ciencia da Computacao',
          institution: 'Instituto Federal',
          schoolName: 'Campus Morrinhos',
          campus: 'Morrinhos',
          degreeLabel: 'Bacharelado',
          isActive: true,
          totalCourseHours: 3000,
          semesterCount: 8,
          requiredComplementaryHours: 80,
          requiredInternshipHours: 0,
          requiredExtensionHours: 200,
        );
        await context.container
            .read(academicProfileRepositoryProvider)
            .saveProfile(existingProfile);

        await context.container
            .read(courseSubjectRepositoryProvider)
            .saveSubject(
              CourseSubject(
                id: 'subject-1',
                remoteId: null,
                createdAt: DateTime(2026, 3, 1),
                updatedAt: DateTime(2026, 3, 1, 12),
                syncStatus: SyncStatus.synced,
                isDeleted: false,
                academicProfileId: existingProfile.id,
                name: 'Algoritmos e Programacao de Computadores',
                code: null,
                workloadHours: 60,
                electiveHours: null,
                suggestedSemester: 1,
                prerequisiteSubjectIds: const <String>[],
                scheduledWeekday: null,
                defaultLessonHours: null,
                type: CourseSubjectType.mandatory,
                status: CourseSubjectStatus.notStarted,
                notes: null,
              ),
            );
        await context.container
            .read(courseSubjectRepositoryProvider)
            .saveSubject(
              CourseSubject(
                id: 'subject-legacy',
                remoteId: null,
                createdAt: DateTime(2026, 3, 1),
                updatedAt: DateTime(2026, 3, 1, 12),
                syncStatus: SyncStatus.synced,
                isDeleted: false,
                academicProfileId: existingProfile.id,
                name: 'Calculo Numerico Legado',
                code: null,
                workloadHours: 72,
                electiveHours: null,
                suggestedSemester: 4,
                prerequisiteSubjectIds: const <String>[],
                scheduledWeekday: null,
                defaultLessonHours: null,
                type: CourseSubjectType.mandatory,
                status: CourseSubjectStatus.notStarted,
                notes: null,
              ),
            );

        final success = await context.container
            .read(curriculumImportControllerProvider.notifier)
            .importCurriculum(
              _samplePreview(),
              targetProfileId: existingProfile.id,
              removeMissingSubjects: true,
            );

        final subjects = await context.container
            .read(courseSubjectRepositoryProvider)
            .getAllSubjects(academicProfileId: existingProfile.id);
        final legacySubject = await context.container
            .read(courseSubjectRepositoryProvider)
            .findById('subject-legacy');

        expect(success, isTrue);
        expect(subjects, hasLength(2));
        expect(
          subjects.any((subject) => subject.name == 'Calculo Numerico Legado'),
          isFalse,
        );
        expect(legacySubject?.isDeleted, isTrue);
      },
    );
  });
}

CurriculumImportPreview _samplePreview() {
  return const CurriculumImportPreview(
    profileName: 'BCC',
    courseName: 'Ciencia da Computacao',
    institution: 'Instituto Federal',
    totalCourseHours: 3200,
    semesterCount: 8,
    requiredComplementaryHours: 108,
    requiredInternshipHours: 0,
    requiredExtensionHours: 320,
    notes: <String>[],
    subjects: [
      CurriculumImportSubjectDraft(
        localId: 'subj-1',
        name: 'Algoritmos e Programacao de Computadores',
        workloadHours: 72,
        type: CourseSubjectType.mandatory,
        suggestedSemester: 1,
      ),
      CurriculumImportSubjectDraft(
        localId: 'subj-2',
        name: 'Estruturas de Dados I',
        workloadHours: 72,
        type: CourseSubjectType.mandatory,
        suggestedSemester: 2,
        prerequisiteLocalIds: ['subj-1'],
      ),
    ],
  );
}

Future<_TestContext> _buildTestContext() async {
  SharedPreferences.setMockInitialValues({});
  final preferences = await SharedPreferences.getInstance();
  final database = AppDatabase(executor: NativeDatabase.memory());
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(preferences),
      appDatabaseProvider.overrideWithValue(database),
    ],
  );
  return _TestContext(container: container, database: database);
}

class _TestContext {
  const _TestContext({required this.container, required this.database});

  final ProviderContainer container;
  final AppDatabase database;

  Future<void> dispose() async {
    container.dispose();
    await database.close();
  }
}
