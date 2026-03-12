// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/attachments/attachment_category.dart';
import '../../../../core/attachments/attachment_draft.dart';
import '../../../../core/attachments/attachment_owner_type.dart';
import '../../../../core/attachments/attachment_providers.dart';
import '../../../../core/attachments/stored_attachment.dart';
import '../../../../core/sync/sync_status.dart';
import '../../../../core/utils/entity_helpers.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/course_subject_lesson.dart';
import 'course_subjects_provider.dart';

class CourseSubjectLessonFormController
    extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<CourseSubjectLesson?> submit({
    required CourseSubjectLesson? current,
    required String courseSubjectId,
    required DateTime lessonDate,
    required double lessonHours,
    required String coveredContent,
    required String? description,
    required String? activityDescription,
    required String? assessmentDescription,
    required DateTime? assessmentDate,
    required List<AttachmentDraft> attachments,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final lesson = CourseSubjectLesson(
        id: current?.id ?? IdGenerator.generate(),
        remoteId: current?.remoteId,
        createdAt: current?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(current?.syncStatus),
        isDeleted: false,
        courseSubjectId: courseSubjectId,
        lessonDate: lessonDate,
        lessonHours: lessonHours,
        coveredContent: coveredContent,
        description: description,
        activityDescription: activityDescription,
        assessmentDescription: assessmentDescription,
        assessmentDate: assessmentDate,
        pdfName: null,
        pdfBytes: null,
      );

      await ref.read(courseSubjectRepositoryProvider).saveLesson(lesson);
      await ref.read(attachmentRepositoryProvider).replaceForOwner(
            ownerType: AttachmentOwnerType.courseSubjectLesson,
            ownerId: lesson.id,
            attachments: attachments
                .map(
                  (attachment) => StoredAttachment(
                    id: attachment.id,
                    createdAt: now,
                    updatedAt: now,
                    syncStatus: SyncStatus.pendingCreate,
                    isDeleted: false,
                    ownerType: AttachmentOwnerType.courseSubjectLesson,
                    ownerId: lesson.id,
                    fileName: attachment.fileName,
                    bytes: attachment.bytes,
                    mimeType: attachment.mimeType,
                    category: attachment.category,
                    dueDate: attachment.category.supportsDeadline
                        ? attachment.dueDate
                        : null,
                    isCompleted: attachment.isCompleted,
                  ),
                )
                .toList(),
          );
      state = const FormSubmissionState.success('Aula salva com sucesso.');
      return lesson;
    } catch (error) {
      state = FormSubmissionState.error('Nao foi possivel salvar a aula: $error');
      return null;
    }
  }
}

final courseSubjectLessonFormControllerProvider = NotifierProvider.autoDispose<
    CourseSubjectLessonFormController,
    FormSubmissionState>(
  CourseSubjectLessonFormController.new,
);
