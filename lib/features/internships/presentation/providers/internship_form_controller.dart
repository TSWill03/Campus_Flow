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
import '../../domain/entities/internship_record.dart';
import 'internships_provider.dart';

class InternshipFormController extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<bool> submit({
    required InternshipRecord? current,
    required String academicProfileId,
    required String location,
    required String? supervisor,
    required DateTime startDate,
    required DateTime? endDate,
    required int totalHours,
    required int completedHours,
    required InternshipStatus status,
    required String? notes,
    required List<AttachmentDraft> attachments,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final internship = InternshipRecord(
        id: current?.id ?? IdGenerator.generate(),
        remoteId: current?.remoteId,
        createdAt: current?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(current?.syncStatus),
        isDeleted: false,
        academicProfileId: academicProfileId,
        location: location,
        supervisor: supervisor,
        startDate: startDate,
        endDate: endDate,
        totalHours: totalHours,
        completedHours: completedHours,
        status: status,
        notes: notes,
      );

      await ref.read(internshipRepositoryProvider).saveInternship(internship);
      await ref.read(attachmentRepositoryProvider).replaceForOwner(
            ownerType: AttachmentOwnerType.internshipRecord,
            ownerId: internship.id,
            attachments: attachments
                .map(
                  (attachment) => StoredAttachment(
                    id: attachment.id,
                    createdAt: now,
                    updatedAt: now,
                    syncStatus: SyncStatus.pendingCreate,
                    isDeleted: false,
                    ownerType: AttachmentOwnerType.internshipRecord,
                    ownerId: internship.id,
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
      state = const FormSubmissionState.success('Estagio salvo com sucesso.');
      return true;
    } catch (error) {
      state = FormSubmissionState.error('Nao foi possivel salvar o estagio: $error');
      return false;
    }
  }
}

final internshipFormControllerProvider =
    NotifierProvider.autoDispose<InternshipFormController, FormSubmissionState>(
  InternshipFormController.new,
);
