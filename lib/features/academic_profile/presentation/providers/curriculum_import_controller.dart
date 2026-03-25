// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/sync/sync_status.dart';
import '../../../../core/utils/entity_helpers.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../../course_subjects/domain/entities/course_subject.dart';
import '../../../course_subjects/domain/repositories/course_subject_repository.dart';
import '../../../course_subjects/presentation/providers/course_subjects_provider.dart';
import '../../domain/entities/academic_profile.dart';
import '../../domain/entities/curriculum_import_preview.dart';
import '../../domain/entities/curriculum_import_subject_draft.dart';
import 'academic_profile_provider.dart';

class CurriculumImportController
    extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<bool> importCurriculum(
    CurriculumImportPreview preview, {
    String? targetProfileId,
    bool removeMissingSubjects = false,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final subjectRepository = ref.read(courseSubjectRepositoryProvider);
      if (targetProfileId != null && targetProfileId.isNotEmpty) {
        return _updateExistingProfile(
          preview: preview,
          targetProfileId: targetProfileId,
          now: now,
          subjectRepository: subjectRepository,
          removeMissingSubjects: removeMissingSubjects,
        );
      }

      return _createNewProfile(
        preview: preview,
        now: now,
        subjectRepository: subjectRepository,
      );
    } catch (error) {
      state = FormSubmissionState.error(
        'Nao foi possivel importar a grade do curso: $error',
      );
      return false;
    }
  }

  Future<bool> _createNewProfile({
    required CurriculumImportPreview preview,
    required DateTime now,
    required CourseSubjectRepository subjectRepository,
  }) async {
    final profileId = IdGenerator.generate();
    final prerequisiteLinks = preview.subjects.fold<int>(
      0,
      (sum, subject) => sum + subject.prerequisiteLocalIds.length,
    );

    final profile = AcademicProfile(
      id: profileId,
      remoteId: null,
      createdAt: now,
      updatedAt: now,
      syncStatus: SyncStatus.pendingCreate,
      isDeleted: false,
      profileName: preview.profileName,
      courseName: preview.courseName,
      institution: preview.institution,
      schoolName: preview.schoolName,
      campus: preview.campus,
      degreeLabel: preview.degreeLabel,
      isActive: preview.makeActive,
      totalCourseHours: preview.totalCourseHours,
      semesterCount: preview.semesterCount,
      requiredComplementaryHours: preview.requiredComplementaryHours,
      requiredInternshipHours: preview.requiredInternshipHours,
      requiredExtensionHours: preview.requiredExtensionHours,
    );

    await ref.read(academicProfileRepositoryProvider).saveProfile(profile);

    final subjectIdByLocalId = <String, String>{
      for (final subjectDraft in preview.subjects)
        subjectDraft.localId: IdGenerator.generate(),
    };

    for (final subjectDraft in preview.subjects) {
      final subject = CourseSubject(
        id: subjectIdByLocalId[subjectDraft.localId]!,
        remoteId: null,
        createdAt: now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(null),
        isDeleted: false,
        academicProfileId: profileId,
        name: subjectDraft.name,
        code: _nullIfBlank(subjectDraft.code),
        workloadHours: subjectDraft.workloadHours,
        electiveHours: subjectDraft.type == CourseSubjectType.elective
            ? subjectDraft.workloadHours
            : null,
        suggestedSemester: subjectDraft.suggestedSemester,
        prerequisiteSubjectIds: subjectDraft.prerequisiteLocalIds
            .map((localId) => subjectIdByLocalId[localId])
            .whereType<String>()
            .toList(),
        scheduledWeekday: null,
        defaultLessonHours: null,
        type: subjectDraft.type,
        status: CourseSubjectStatus.notStarted,
        creditSourceSubjectId: subjectDraft.creditSourceSubjectId,
        creditSourceProfileId: subjectDraft.creditSourceProfileId,
        creditStatus: subjectDraft.creditStatus,
        creditMatchScore: subjectDraft.creditMatchScore,
        syllabus: _nullIfBlank(subjectDraft.syllabus),
        notes: _nullIfBlank(subjectDraft.notes),
      );
      await subjectRepository.saveSubject(subject);
    }

    state = FormSubmissionState.success(
      'Grade importada com sucesso. ${preview.subjects.length} disciplinas foram criadas e $prerequisiteLinks vinculo(s) de pre-requisito foram aplicados.',
    );
    return true;
  }

  Future<bool> _updateExistingProfile({
    required CurriculumImportPreview preview,
    required String targetProfileId,
    required DateTime now,
    required CourseSubjectRepository subjectRepository,
    required bool removeMissingSubjects,
  }) async {
    final profileRepository = ref.read(academicProfileRepositoryProvider);
    final currentProfile = await profileRepository.findById(targetProfileId);
    if (currentProfile == null) {
      throw StateError('Perfil academico selecionado nao foi encontrado.');
    }

    final updatedProfile = currentProfile.copyWith(
      updatedAt: now,
      syncStatus: resolveUpsertSyncStatus(currentProfile.syncStatus),
      isDeleted: false,
      profileName: preview.profileName,
      courseName: preview.courseName,
      institution: preview.institution,
      schoolName: preview.schoolName,
      campus: preview.campus,
      degreeLabel: preview.degreeLabel,
      isActive: preview.makeActive,
      totalCourseHours: preview.totalCourseHours,
      semesterCount: preview.semesterCount,
      requiredComplementaryHours: preview.requiredComplementaryHours,
      requiredInternshipHours: preview.requiredInternshipHours,
      requiredExtensionHours: preview.requiredExtensionHours,
    );
    await profileRepository.saveProfile(updatedProfile);

    final existingSubjects = await subjectRepository.getAllSubjects(
      academicProfileId: targetProfileId,
    );
    final plans = _buildSubjectImportPlans(preview.subjects, existingSubjects);
    final subjectIdByLocalId = {
      for (final plan in plans) plan.draft.localId: plan.subjectId,
    };
    final matchedExistingIds = plans
        .map((plan) => plan.existingSubject?.id)
        .whereType<String>()
        .toSet();

    var createdCount = 0;
    var updatedCount = 0;
    var removedCount = 0;
    var prerequisiteLinks = 0;

    for (final plan in plans) {
      final subject = CourseSubject(
        id: plan.subjectId,
        remoteId: plan.existingSubject?.remoteId,
        createdAt: plan.existingSubject?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(plan.existingSubject?.syncStatus),
        isDeleted: false,
        academicProfileId: targetProfileId,
        name: plan.draft.name,
        code: _nullIfBlank(plan.draft.code) ?? plan.existingSubject?.code,
        workloadHours: plan.draft.workloadHours,
        electiveHours: plan.draft.type == CourseSubjectType.elective
            ? plan.draft.workloadHours
            : null,
        suggestedSemester:
            plan.draft.suggestedSemester ??
            plan.existingSubject?.suggestedSemester,
        prerequisiteSubjectIds: plan.draft.prerequisiteLocalIds
            .map((localId) => subjectIdByLocalId[localId])
            .whereType<String>()
            .toList(),
        scheduledWeekday: plan.existingSubject?.scheduledWeekday,
        defaultLessonHours: plan.existingSubject?.defaultLessonHours,
        type: plan.draft.type,
        status: plan.existingSubject?.status ?? CourseSubjectStatus.notStarted,
        creditSourceSubjectId:
            plan.draft.creditSourceSubjectId ??
            plan.existingSubject?.creditSourceSubjectId,
        creditSourceProfileId:
            plan.draft.creditSourceProfileId ??
            plan.existingSubject?.creditSourceProfileId,
        creditStatus: plan.draft.creditStatus != CourseSubjectCreditStatus.none
            ? plan.draft.creditStatus
            : plan.existingSubject?.creditStatus ??
                  CourseSubjectCreditStatus.none,
        creditMatchScore:
            plan.draft.creditMatchScore ?? plan.existingSubject?.creditMatchScore,
        syllabus:
            _nullIfBlank(plan.draft.syllabus) ?? plan.existingSubject?.syllabus,
        notes: plan.existingSubject?.notes ?? _nullIfBlank(plan.draft.notes),
      );
      prerequisiteLinks += subject.prerequisiteSubjectIds.length;
      await subjectRepository.saveSubject(subject);
      if (plan.existingSubject == null) {
        createdCount++;
      } else {
        updatedCount++;
      }
    }

    if (removeMissingSubjects) {
      final subjectsToRemove = existingSubjects
          .where((subject) => !matchedExistingIds.contains(subject.id))
          .toList();
      for (final subject in subjectsToRemove) {
        await subjectRepository.deleteSubject(subject.id);
      }
      removedCount = subjectsToRemove.length;
    }

    state = FormSubmissionState.success(
      'Perfil atualizado. $updatedCount disciplina(s) foram atualizadas, $createdCount disciplina(s) novas foram criadas, $removedCount disciplina(s) antigas foram removidas e $prerequisiteLinks vinculo(s) de pre-requisito foram aplicados.',
    );
    return true;
  }

  List<_SubjectImportPlan> _buildSubjectImportPlans(
    List<CurriculumImportSubjectDraft> drafts,
    List<CourseSubject> existingSubjects,
  ) {
    final existingByCode = <String, CourseSubject>{};
    final existingByName = <String, CourseSubject>{};
    for (final subject in existingSubjects) {
      final normalizedCode = _normalizedCode(subject.code);
      if (normalizedCode != null) {
        existingByCode.putIfAbsent(normalizedCode, () => subject);
      }
      existingByName.putIfAbsent(_normalizedName(subject.name), () => subject);
    }

    final usedExistingIds = <String>{};
    return drafts.map<_SubjectImportPlan>((draft) {
      CourseSubject? matchedSubject;
      final normalizedCode = _normalizedCode(draft.code);
      if (normalizedCode != null) {
        final candidate = existingByCode[normalizedCode];
        if (candidate != null && usedExistingIds.add(candidate.id)) {
          matchedSubject = candidate;
        }
      }

      if (matchedSubject == null) {
        final candidate = existingByName[_normalizedName(draft.name)];
        if (candidate != null && usedExistingIds.add(candidate.id)) {
          matchedSubject = candidate;
        }
      }

      return _SubjectImportPlan(
        draft: draft,
        existingSubject: matchedSubject,
        subjectId: matchedSubject?.id ?? IdGenerator.generate(),
      );
    }).toList();
  }

  String _normalizedName(String value) {
    const replacements = {
      'a': 'áàâãä',
      'e': 'éèêë',
      'i': 'íìîï',
      'o': 'óòôõö',
      'u': 'úùûü',
      'c': 'ç',
      'n': 'ñ',
    };

    var normalized = value.toLowerCase();
    replacements.forEach((ascii, chars) {
      for (final char in chars.split('')) {
        normalized = normalized.replaceAll(char, ascii);
      }
    });

    return normalized.replaceAll(RegExp(r'[^a-z0-9]'), '').trim();
  }

  String? _normalizedCode(String? value) {
    final cleaned = _nullIfBlank(value);
    if (cleaned == null) {
      return null;
    }
    return cleaned.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '').trim();
  }

  String? _nullIfBlank(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return value.trim();
  }
}

class _SubjectImportPlan {
  const _SubjectImportPlan({
    required this.draft,
    required this.subjectId,
    this.existingSubject,
  });

  final CurriculumImportSubjectDraft draft;
  final String subjectId;
  final CourseSubject? existingSubject;
}

final curriculumImportControllerProvider =
    NotifierProvider.autoDispose<
      CurriculumImportController,
      FormSubmissionState
    >(CurriculumImportController.new);
