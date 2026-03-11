import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/entity_helpers.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/academic_profile.dart';
import 'academic_profile_provider.dart';

class AcademicProfileFormController extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<bool> submit({
    required AcademicProfile? current,
    required String profileName,
    required String institution,
    required String? schoolName,
    required String? campus,
    required String? degreeLabel,
    required String courseName,
    required int totalCourseHours,
    required int semesterCount,
    required int requiredComplementaryHours,
    required int requiredInternshipHours,
    required int requiredExtensionHours,
    required bool isActive,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final profile = AcademicProfile(
        id: current?.id ?? IdGenerator.generate(),
        remoteId: current?.remoteId,
        createdAt: current?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(current?.syncStatus),
        isDeleted: false,
        profileName: profileName,
        courseName: courseName,
        institution: institution,
        schoolName: schoolName,
        campus: campus,
        degreeLabel: degreeLabel,
        isActive: isActive,
        totalCourseHours: totalCourseHours,
        semesterCount: semesterCount,
        requiredComplementaryHours: requiredComplementaryHours,
        requiredInternshipHours: requiredInternshipHours,
        requiredExtensionHours: requiredExtensionHours,
      );

      await ref.read(academicProfileRepositoryProvider).saveProfile(profile);
      state = const FormSubmissionState.success('Perfil academico salvo com sucesso.');
      return true;
    } catch (error) {
      state = FormSubmissionState.error('Nao foi possivel salvar o perfil: $error');
      return false;
    }
  }
}

final academicProfileFormControllerProvider =
    NotifierProvider.autoDispose<AcademicProfileFormController, FormSubmissionState>(
  AcademicProfileFormController.new,
);
