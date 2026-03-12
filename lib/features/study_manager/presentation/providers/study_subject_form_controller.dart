// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/entity_helpers.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/study_subject.dart';
import 'study_manager_provider.dart';

class StudySubjectFormController extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<bool> submit({
    required StudySubject? current,
    required String name,
    required int? colorValue,
    required String? description,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final subject = StudySubject(
        id: current?.id ?? IdGenerator.generate(),
        remoteId: current?.remoteId,
        createdAt: current?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(current?.syncStatus),
        isDeleted: false,
        name: name,
        colorValue: colorValue,
        description: description,
      );

      await ref.read(studyManagerRepositoryProvider).saveSubject(subject);
      state = const FormSubmissionState.success('Materia salva com sucesso.');
      return true;
    } catch (error) {
      state = FormSubmissionState.error('Nao foi possivel salvar a materia: $error');
      return false;
    }
  }
}

final studySubjectFormControllerProvider =
    NotifierProvider.autoDispose<StudySubjectFormController, FormSubmissionState>(
  StudySubjectFormController.new,
);
