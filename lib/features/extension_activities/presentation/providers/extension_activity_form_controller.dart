// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/entity_helpers.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/extension_activity.dart';
import 'extension_activities_provider.dart';

class ExtensionActivityFormController extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<bool> submit({
    required ExtensionActivity? current,
    required String academicProfileId,
    required String title,
    required String type,
    required DateTime date,
    required int workloadHours,
    required String? notes,
    required ValidationStatus status,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final activity = ExtensionActivity(
        id: current?.id ?? IdGenerator.generate(),
        remoteId: current?.remoteId,
        createdAt: current?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(current?.syncStatus),
        isDeleted: false,
        academicProfileId: academicProfileId,
        title: title,
        type: type,
        date: date,
        workloadHours: workloadHours,
        notes: notes,
        status: status,
      );

      await ref.read(extensionActivityRepositoryProvider).saveActivity(activity);
      state = const FormSubmissionState.success('Atividade de extensao salva com sucesso.');
      return true;
    } catch (error) {
      state = FormSubmissionState.error('Nao foi possivel salvar a atividade: $error');
      return false;
    }
  }
}

final extensionActivityFormControllerProvider = NotifierProvider.autoDispose<
    ExtensionActivityFormController,
    FormSubmissionState>(
  ExtensionActivityFormController.new,
);
