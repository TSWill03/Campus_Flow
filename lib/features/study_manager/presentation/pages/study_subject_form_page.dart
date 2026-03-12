// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/study_subject.dart';
import '../providers/study_subject_form_controller.dart';
import '../providers/study_manager_provider.dart';

class StudySubjectFormPage extends ConsumerWidget {
  const StudySubjectFormPage({
    super.key,
    this.subjectId,
  });

  final String? subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (subjectId == null) {
      return const _StudySubjectForm();
    }

    final subjectAsync = ref.watch(studySubjectByIdProvider(subjectId!));
    return AsyncValueView<StudySubject?>(
      value: subjectAsync,
      data: (subject) => _StudySubjectForm(initialSubject: subject),
    );
  }
}

class _StudySubjectForm extends ConsumerStatefulWidget {
  const _StudySubjectForm({this.initialSubject});

  final StudySubject? initialSubject;

  @override
  ConsumerState<_StudySubjectForm> createState() => _StudySubjectFormState();
}

class _StudySubjectFormState extends ConsumerState<_StudySubjectForm> {
  static const _colors = <int>[
    0xFF0F766E,
    0xFFE67E22,
    0xFF2B6CB0,
    0xFF7B2CBF,
    0xFFC53030,
    0xFF2F855A,
  ];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  int? _selectedColorValue;

  @override
  void initState() {
    super.initState();
    final subject = widget.initialSubject;
    _nameController = TextEditingController(text: subject?.name ?? '');
    _descriptionController =
        TextEditingController(text: subject?.description ?? '');
    _selectedColorValue = subject?.colorValue;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submissionState = ref.watch(studySubjectFormControllerProvider);
    ref.listen<FormSubmissionState>(
      studySubjectFormControllerProvider,
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
            SnackBar(content: Text(next.message ?? 'Materia salva com sucesso.')),
          );
          Navigator.of(context).pop();
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialSubject == null ? 'Nova materia' : 'Editar materia'),
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
                          decoration:
                              const InputDecoration(labelText: 'Nome da materia'),
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
                        Text(
                          'Cor da materia',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: _colors
                              .map(
                                (colorValue) => ChoiceChip(
                                  label: const Text(''),
                                  selected: _selectedColorValue == colorValue,
                                  avatar: CircleAvatar(
                                    backgroundColor: Color(colorValue),
                                  ),
                                  onSelected: (_) {
                                    setState(() => _selectedColorValue = colorValue);
                                  },
                                ),
                              )
                              .toList()
                            ..add(
                              ChoiceChip(
                                label: const Text('Sem cor'),
                                selected: _selectedColorValue == null,
                                onSelected: (_) {
                                  setState(() => _selectedColorValue = null);
                                },
                              ),
                            ),
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
                          label: const Text('Salvar materia'),
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

    await ref.read(studySubjectFormControllerProvider.notifier).submit(
          current: widget.initialSubject,
          name: _nameController.text.trim(),
          colorValue: _selectedColorValue,
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
        );
  }
}
