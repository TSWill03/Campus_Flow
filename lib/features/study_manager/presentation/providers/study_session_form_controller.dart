// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/entity_helpers.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/study_session.dart';
import 'study_manager_provider.dart';

class StudySessionFormController extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<bool> submit({
    required StudySession? current,
    required String? studySubjectId,
    required String? studyTopicId,
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationMinutes,
    required String? notes,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final session = StudySession(
        id: current?.id ?? IdGenerator.generate(),
        remoteId: current?.remoteId,
        createdAt: current?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(current?.syncStatus),
        isDeleted: false,
        studySubjectId: studySubjectId,
        studyTopicId: studyTopicId,
        startedAt: startedAt,
        endedAt: endedAt,
        durationMinutes: durationMinutes,
        notes: notes,
      );

      await ref.read(studyManagerRepositoryProvider).saveSession(session);
      state = const FormSubmissionState.success('Sessao salva com sucesso.');
      return true;
    } catch (error) {
      state = FormSubmissionState.error('Nao foi possivel salvar a sessao: $error');
      return false;
    }
  }
}

final studySessionFormControllerProvider =
    NotifierProvider.autoDispose<StudySessionFormController, FormSubmissionState>(
  StudySessionFormController.new,
);
