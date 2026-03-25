// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/entity_helpers.dart';
import '../../../../core/utils/id_generator.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/course_subject.dart';
import 'course_subjects_provider.dart';

class CourseSubjectFormController
    extends AutoDisposeNotifier<FormSubmissionState> {
  @override
  FormSubmissionState build() => const FormSubmissionState.idle();

  Future<CourseSubject?> submit({
    required CourseSubject? current,
    required String academicProfileId,
    required String name,
    required String? code,
    required int workloadHours,
    required int? electiveHours,
    required int? suggestedSemester,
    required List<String> prerequisiteSubjectIds,
    required int? scheduledWeekday,
    required double? defaultLessonHours,
    required CourseSubjectType type,
    required CourseSubjectStatus status,
    required String? syllabus,
    required String? notes,
  }) async {
    state = const FormSubmissionState.loading();

    try {
      final now = DateTime.now();
      final subject = CourseSubject(
        id: current?.id ?? IdGenerator.generate(),
        remoteId: current?.remoteId,
        createdAt: current?.createdAt ?? now,
        updatedAt: now,
        syncStatus: resolveUpsertSyncStatus(current?.syncStatus),
        isDeleted: false,
        academicProfileId: academicProfileId,
        name: name,
        code: code,
        workloadHours: workloadHours,
        electiveHours: electiveHours,
        suggestedSemester: suggestedSemester,
        prerequisiteSubjectIds: prerequisiteSubjectIds,
        scheduledWeekday: scheduledWeekday,
        defaultLessonHours: defaultLessonHours,
        type: type,
        status: status,
        creditSourceSubjectId: current?.creditSourceSubjectId,
        creditSourceProfileId: current?.creditSourceProfileId,
        creditStatus: current?.creditStatus ?? CourseSubjectCreditStatus.none,
        creditMatchScore: current?.creditMatchScore,
        syllabus: syllabus,
        notes: notes,
      );

      await ref.read(courseSubjectRepositoryProvider).saveSubject(subject);
      state = const FormSubmissionState.success(
        'Disciplina salva com sucesso.',
      );
      return subject;
    } catch (error) {
      state = FormSubmissionState.error(
        'Nao foi possivel salvar a disciplina: $error',
      );
      return null;
    }
  }
}

final courseSubjectFormControllerProvider =
    NotifierProvider.autoDispose<
      CourseSubjectFormController,
      FormSubmissionState
    >(CourseSubjectFormController.new);
