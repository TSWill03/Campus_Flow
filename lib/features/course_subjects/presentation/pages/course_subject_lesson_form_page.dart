import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/attachments/attachment_category.dart';
import '../../../../core/attachments/attachment_draft.dart';
import '../../../../core/attachments/attachment_owner_type.dart';
import '../../../../core/attachments/attachment_providers.dart';
import '../../../../core/attachments/stored_attachment.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/attachment_editor_section.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/course_subject_lesson.dart';
import '../providers/course_subject_lesson_form_controller.dart';
import '../providers/course_subjects_provider.dart';

class CourseSubjectLessonFormPage extends ConsumerWidget {
  const CourseSubjectLessonFormPage({
    super.key,
    required this.subjectId,
    this.lessonId,
  });

  final String subjectId;
  final String? lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (lessonId == null) {
      return _CourseSubjectLessonForm(subjectId: subjectId);
    }

    final lessonAsync = ref.watch(courseSubjectLessonByIdProvider(lessonId!));
    return AsyncValueView<CourseSubjectLesson?>(
      value: lessonAsync,
      data: (lesson) => _CourseSubjectLessonForm(
        subjectId: subjectId,
        initialLesson: lesson,
      ),
    );
  }
}

class _CourseSubjectLessonForm extends ConsumerStatefulWidget {
  const _CourseSubjectLessonForm({
    required this.subjectId,
    this.initialLesson,
  });

  final String subjectId;
  final CourseSubjectLesson? initialLesson;

  @override
  ConsumerState<_CourseSubjectLessonForm> createState() =>
      _CourseSubjectLessonFormState();
}

class _CourseSubjectLessonFormState
    extends ConsumerState<_CourseSubjectLessonForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _contentController;
  late final TextEditingController _hoursController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _activityController;
  late final TextEditingController _assessmentController;
  late DateTime _lessonDate;
  DateTime? _assessmentDate;
  List<AttachmentDraft> _attachments = const [];
  bool _attachmentsHydrated = false;

  @override
  void initState() {
    super.initState();
    final lesson = widget.initialLesson;
    _contentController =
        TextEditingController(text: lesson?.coveredContent ?? '');
    _hoursController = TextEditingController(
      text: lesson?.lessonHours.toString().replaceAll('.', ',') ?? '',
    );
    _descriptionController =
        TextEditingController(text: lesson?.description ?? '');
    _activityController =
        TextEditingController(text: lesson?.activityDescription ?? '');
    _assessmentController =
        TextEditingController(text: lesson?.assessmentDescription ?? '');
    _lessonDate = lesson?.lessonDate ?? DateTime.now();
    _assessmentDate = lesson?.assessmentDate;
  }

  @override
  void dispose() {
    _contentController.dispose();
    _hoursController.dispose();
    _descriptionController.dispose();
    _activityController.dispose();
    _assessmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ownerKey = (
      ownerType: AttachmentOwnerType.courseSubjectLesson,
      ownerId: widget.initialLesson?.id ?? '',
    );
    final attachmentsAsync = widget.initialLesson == null
        ? const AsyncData<List<StoredAttachment>>([])
        : ref.watch(ownerAttachmentsProvider(ownerKey));
    final submissionState = ref.watch(courseSubjectLessonFormControllerProvider);
    ref.listen<FormSubmissionState>(
      courseSubjectLessonFormControllerProvider,
      (previous, next) {
        if (!mounted || previous?.status == next.status) {
          return;
        }

        if (next.isError && next.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.message!)),
          );
        }

        if (next.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.message ?? 'Aula salva com sucesso.')),
          );
          Navigator.of(context).pop();
        }
      },
    );

    if (!_attachmentsHydrated) {
      final storedAttachments = attachmentsAsync.valueOrNull;
      if (storedAttachments != null) {
        _attachments = storedAttachments.isNotEmpty
            ? storedAttachments.map(_draftFromStored).toList()
            : _legacyDraftsFromLesson(widget.initialLesson);
        _attachmentsHydrated = true;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialLesson == null ? 'Nova aula' : 'Editar aula'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        TextFormField(
                          controller: _contentController,
                          decoration: const InputDecoration(
                            labelText: 'Conteudo da aula',
                            hintText: 'Ex.: Introducao, calculo vetorial, seminario...',
                          ),
                          validator: _required,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _hoursController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Carga da aula (horas)',
                            hintText: 'Ex.: 2 ou 1,5',
                          ),
                          validator: _hoursValidator,
                        ),
                        const SizedBox(height: 16),
                        _DateTile(
                          title: 'Data da aula',
                          subtitle: AppFormatters.formatDate(_lessonDate),
                          onTap: () => _pickLessonDate(context),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          minLines: 3,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: 'Observacoes da aula (opcional)',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _activityController,
                          minLines: 2,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Atividade enviada (opcional)',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _assessmentController,
                          decoration: const InputDecoration(
                            labelText: 'Prova ou avaliacao (opcional)',
                            hintText: 'Ex.: Prova 1, quiz, seminario...',
                          ),
                        ),
                        const SizedBox(height: 16),
                        _DateTile(
                          title: 'Data da prova (opcional)',
                          subtitle: _assessmentDate == null
                              ? 'Nao definida'
                              : AppFormatters.formatDate(_assessmentDate),
                          onTap: () => _pickAssessmentDate(context),
                          trailing: _assessmentDate == null
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    setState(() => _assessmentDate = null);
                                  },
                                  icon: const Icon(Icons.close_rounded),
                                ),
                        ),
                        const SizedBox(height: 16),
                        AttachmentEditorSection(
                          title: 'Arquivos da aula',
                          subtitle:
                              'Voce pode anexar quantos arquivos quiser e classificar cada um como aula, atividade, slide ou outro.',
                          attachments: _attachments,
                          allowedCategories: const [
                            AttachmentCategory.lessonMaterial,
                            AttachmentCategory.activity,
                            AttachmentCategory.slide,
                            AttachmentCategory.document,
                            AttachmentCategory.archive,
                            AttachmentCategory.other,
                          ],
                          onChanged: (attachments) {
                            setState(() => _attachments = attachments);
                          },
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: submissionState.isLoading ? null : _save,
                          icon: submissionState.isLoading
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.save_rounded),
                          label: const Text('Salvar aula'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatorio';
    }
    return null;
  }

  String? _hoursValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe a carga da aula';
    }

    final parsed = _parseHours(value);
    if (parsed == null || parsed <= 0) {
      return 'Numero invalido';
    }

    return null;
  }

  double? _parseHours(String value) {
    return double.tryParse(value.trim().replaceAll(',', '.'));
  }

  Future<void> _pickLessonDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _lessonDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _lessonDate = picked);
    }
  }

  Future<void> _pickAssessmentDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _assessmentDate ?? _lessonDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _assessmentDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final lessonHours = _parseHours(_hoursController.text);
    if (lessonHours == null || lessonHours <= 0) {
      return;
    }

    await ref.read(courseSubjectLessonFormControllerProvider.notifier).submit(
          current: widget.initialLesson,
          courseSubjectId: widget.subjectId,
          lessonDate: _lessonDate,
          lessonHours: lessonHours,
          coveredContent: _contentController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          activityDescription: _activityController.text.trim().isEmpty
              ? null
              : _activityController.text.trim(),
          assessmentDescription: _assessmentController.text.trim().isEmpty
              ? null
              : _assessmentController.text.trim(),
          assessmentDate: _assessmentDate,
          attachments: _attachments,
        );
  }

  AttachmentDraft _draftFromStored(StoredAttachment attachment) {
    return AttachmentDraft(
      id: attachment.id,
      fileName: attachment.fileName,
      bytes: attachment.bytes,
      mimeType: attachment.mimeType,
      category: attachment.category,
      dueDate: attachment.dueDate,
      isCompleted: attachment.isCompleted,
    );
  }

  List<AttachmentDraft> _legacyDraftsFromLesson(CourseSubjectLesson? lesson) {
    if (lesson?.pdfName == null || lesson?.pdfBytes == null) {
      return const [];
    }

    return [
      AttachmentDraft(
        id: 'legacy_${lesson!.id}',
        fileName: lesson.pdfName!,
        bytes: lesson.pdfBytes!,
        mimeType: 'application/pdf',
        category: AttachmentCategory.document,
      ),
    ];
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing ?? const Icon(Icons.calendar_today_rounded),
      onTap: onTap,
    );
  }
}
