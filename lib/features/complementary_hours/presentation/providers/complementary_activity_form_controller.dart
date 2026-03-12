// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/attachments/attachment_draft.dart';
import '../../../../core/attachments/attachment_owner_type.dart';
import '../../../../core/attachments/attachment_providers.dart';
import '../../../../core/attachments/stored_attachment.dart';
import '../../../../core/sync/sync_status.dart';
import '../../../../core/utils/entity_helpers.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/complementary_activity.dart';
import 'complementary_activities_provider.dart';

class ComplementaryActivityFormController extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<bool> submit({
    required ComplementaryActivity? current,
    required String academicProfileId,
    required String title,
    required String category,
    required DateTime date,
    required DateTime? endDate,
    required int workloadHours,
    required String? notes,
    required ValidationStatus status,
    required List<AttachmentDraft> attachments,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final activity = ComplementaryActivity(
        id: current?.id ?? IdGenerator.generate(),
        remoteId: current?.remoteId,
        createdAt: current?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(current?.syncStatus),
        isDeleted: false,
        academicProfileId: academicProfileId,
        title: title,
        category: category,
        date: date,
        endDate: endDate,
        workloadHours: workloadHours,
        notes: notes,
        status: status,
      );

      await ref.read(complementaryActivityRepositoryProvider).saveActivity(activity);
      await ref.read(attachmentRepositoryProvider).replaceForOwner(
            ownerType: AttachmentOwnerType.complementaryActivity,
            ownerId: activity.id,
            attachments: attachments
                .map(
                  (attachment) => StoredAttachment(
                    id: attachment.id,
                    createdAt: now,
                    updatedAt: now,
                    syncStatus: SyncStatus.pendingCreate,
                    isDeleted: false,
                    ownerType: AttachmentOwnerType.complementaryActivity,
                    ownerId: activity.id,
                    fileName: attachment.fileName,
                    bytes: attachment.bytes,
                    mimeType: attachment.mimeType,
                    category: attachment.category,
                    dueDate: null,
                    isCompleted: false,
                  ),
                )
                .toList(),
          );
      state = const FormSubmissionState.success('Atividade complementar salva com sucesso.');
      return true;
    } catch (error) {
      state = FormSubmissionState.error('Nao foi possivel salvar a atividade: $error');
      return false;
    }
  }
}

final complementaryActivityFormControllerProvider = NotifierProvider.autoDispose<
    ComplementaryActivityFormController,
    FormSubmissionState>(
  ComplementaryActivityFormController.new,
);
