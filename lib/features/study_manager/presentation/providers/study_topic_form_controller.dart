import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/entity_helpers.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/study_topic.dart';
import 'study_manager_provider.dart';

class StudyTopicFormController extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<bool> submit({
    required StudyTopic? current,
    required String subjectId,
    required String name,
    required String? description,
    required StudyTopicStatus status,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final topic = StudyTopic(
        id: current?.id ?? IdGenerator.generate(),
        remoteId: current?.remoteId,
        createdAt: current?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(current?.syncStatus),
        isDeleted: false,
        studySubjectId: subjectId,
        name: name,
        description: description,
        status: status,
      );

      await ref.read(studyManagerRepositoryProvider).saveTopic(topic);
      state = const FormSubmissionState.success('Topico salvo com sucesso.');
      return true;
    } catch (error) {
      state = FormSubmissionState.error('Nao foi possivel salvar o topico: $error');
      return false;
    }
  }
}

final studyTopicFormControllerProvider =
    NotifierProvider.autoDispose<StudyTopicFormController, FormSubmissionState>(
  StudyTopicFormController.new,
);
