// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/entity_helpers.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/study_task.dart';
import 'study_manager_provider.dart';

class StudyTaskFormController extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<bool> submit({
    required StudyTask? current,
    required String title,
    required String? description,
    required String? studySubjectId,
    required DateTime? dueDate,
    required StudyTaskPriority priority,
    required StudyTaskStatus status,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final task = StudyTask(
        id: current?.id ?? IdGenerator.generate(),
        remoteId: current?.remoteId,
        createdAt: current?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(current?.syncStatus),
        isDeleted: false,
        title: title,
        description: description,
        studySubjectId: studySubjectId,
        dueDate: dueDate,
        priority: priority,
        status: status,
      );

      await ref.read(studyManagerRepositoryProvider).saveTask(task);
      state = const FormSubmissionState.success('Tarefa salva com sucesso.');
      return true;
    } catch (error) {
      state = FormSubmissionState.error('Nao foi possivel salvar a tarefa: $error');
      return false;
    }
  }
}

final studyTaskFormControllerProvider =
    NotifierProvider.autoDispose<StudyTaskFormController, FormSubmissionState>(
  StudyTaskFormController.new,
);
