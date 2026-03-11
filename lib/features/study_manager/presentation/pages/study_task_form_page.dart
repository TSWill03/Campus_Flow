import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_formatters.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/study_subject.dart';
import '../../domain/entities/study_task.dart';
import '../providers/study_task_form_controller.dart';
import '../providers/study_manager_provider.dart';

class StudyTaskFormPage extends ConsumerWidget {
  const StudyTaskFormPage({
    super.key,
    this.taskId,
  });

  final String? taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (taskId == null) {
      return const _StudyTaskForm();
    }

    final taskAsync = ref.watch(studyTaskByIdProvider(taskId!));
    return AsyncValueView<StudyTask?>(
      value: taskAsync,
      data: (task) => _StudyTaskForm(initialTask: task),
    );
  }
}

class _StudyTaskForm extends ConsumerStatefulWidget {
  const _StudyTaskForm({this.initialTask});

  final StudyTask? initialTask;

  @override
  ConsumerState<_StudyTaskForm> createState() => _StudyTaskFormState();
}

class _StudyTaskFormState extends ConsumerState<_StudyTaskForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  DateTime? _dueDate;
  String? _selectedSubjectId;
  late StudyTaskPriority _priority;
  late StudyTaskStatus _status;

  @override
  void initState() {
    super.initState();
    final task = widget.initialTask;
    _titleController = TextEditingController(text: task?.title ?? '');
    _descriptionController = TextEditingController(text: task?.description ?? '');
    _dueDate = task?.dueDate;
    _selectedSubjectId = task?.studySubjectId;
    _priority = task?.priority ?? StudyTaskPriority.medium;
    _status = task?.status ?? StudyTaskStatus.pending;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submissionState = ref.watch(studyTaskFormControllerProvider);
    ref.listen<FormSubmissionState>(
      studyTaskFormControllerProvider,
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
            SnackBar(content: Text(next.message ?? 'Tarefa salva com sucesso.')),
          );
          Navigator.of(context).pop();
        }
      },
    );

    final subjects = ref.watch(studySubjectsProvider).valueOrNull ?? const <StudySubject>[];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialTask == null ? 'Nova tarefa' : 'Editar tarefa'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
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
                          controller: _titleController,
                          decoration: const InputDecoration(labelText: 'Titulo'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Campo obrigatorio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String?>(
                          initialValue: _selectedSubjectId,
                          decoration:
                              const InputDecoration(labelText: 'Materia (opcional)'),
                          items: [
                            const DropdownMenuItem<String?>(
                              value: null,
                              child: Text('Sem materia'),
                            ),
                            ...subjects.map(
                              (subject) => DropdownMenuItem<String?>(
                                value: subject.id,
                                child: Text(subject.name),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => _selectedSubjectId = value);
                          },
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          tileColor:
                              Theme.of(context).colorScheme.surfaceContainerHighest,
                          title: const Text('Prazo'),
                          subtitle: Text(
                            _dueDate == null
                                ? 'Sem prazo definido'
                                : AppFormatters.formatDate(_dueDate),
                          ),
                          trailing: Wrap(
                            spacing: 4,
                            children: [
                              if (_dueDate != null)
                                IconButton(
                                  onPressed: () => setState(() => _dueDate = null),
                                  icon: const Icon(Icons.close_rounded),
                                ),
                              const Icon(Icons.calendar_today_rounded),
                            ],
                          ),
                          onTap: _pickDate,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<StudyTaskPriority>(
                          initialValue: _priority,
                          decoration: const InputDecoration(labelText: 'Prioridade'),
                          items: StudyTaskPriority.values
                              .map(
                                (priority) => DropdownMenuItem(
                                  value: priority,
                                  child: Text(priority.label),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _priority = value);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<StudyTaskStatus>(
                          initialValue: _status,
                          decoration: const InputDecoration(labelText: 'Status'),
                          items: StudyTaskStatus.values
                              .map(
                                (status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status.label),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _status = value);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          minLines: 3,
                          maxLines: 5,
                          decoration:
                              const InputDecoration(labelText: 'Descricao'),
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
                          label: const Text('Salvar tarefa'),
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

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(studyTaskFormControllerProvider.notifier).submit(
          current: widget.initialTask,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          studySubjectId: _selectedSubjectId,
          dueDate: _dueDate,
          priority: _priority,
          status: _status,
        );
  }
}
