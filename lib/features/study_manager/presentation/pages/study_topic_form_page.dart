// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/study_topic.dart';
import '../providers/study_topic_form_controller.dart';
import '../providers/study_manager_provider.dart';

class StudyTopicFormPage extends ConsumerWidget {
  const StudyTopicFormPage({
    super.key,
    required this.subjectId,
    this.topicId,
  });

  final String subjectId;
  final String? topicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (topicId == null) {
      return _StudyTopicForm(subjectId: subjectId);
    }

    final topicAsync = ref.watch(studyTopicByIdProvider(topicId!));
    return AsyncValueView<StudyTopic?>(
      value: topicAsync,
      data: (topic) => _StudyTopicForm(
        subjectId: subjectId,
        initialTopic: topic,
      ),
    );
  }
}

class _StudyTopicForm extends ConsumerStatefulWidget {
  const _StudyTopicForm({
    required this.subjectId,
    this.initialTopic,
  });

  final String subjectId;
  final StudyTopic? initialTopic;

  @override
  ConsumerState<_StudyTopicForm> createState() => _StudyTopicFormState();
}

class _StudyTopicFormState extends ConsumerState<_StudyTopicForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late StudyTopicStatus _status;

  @override
  void initState() {
    super.initState();
    final topic = widget.initialTopic;
    _nameController = TextEditingController(text: topic?.name ?? '');
    _descriptionController = TextEditingController(text: topic?.description ?? '');
    _status = topic?.status ?? StudyTopicStatus.notStarted;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submissionState = ref.watch(studyTopicFormControllerProvider);
    ref.listen<FormSubmissionState>(
      studyTopicFormControllerProvider,
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
            SnackBar(content: Text(next.message ?? 'Topico salvo com sucesso.')),
          );
          Navigator.of(context).pop();
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialTopic == null ? 'Novo topico' : 'Editar topico'),
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
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Nome'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Campo obrigatorio';
                            }
                            return null;
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
                        const SizedBox(height: 16),
                        DropdownButtonFormField<StudyTopicStatus>(
                          initialValue: _status,
                          decoration: const InputDecoration(labelText: 'Status'),
                          items: StudyTopicStatus.values
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
                          label: const Text('Salvar topico'),
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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(studyTopicFormControllerProvider.notifier).submit(
          current: widget.initialTopic,
          subjectId: widget.subjectId,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          status: _status,
        );
  }
}
