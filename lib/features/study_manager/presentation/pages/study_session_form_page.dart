import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/app_formatters.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/study_session.dart';
import '../../domain/entities/study_subject.dart';
import '../../domain/entities/study_topic.dart';
import '../providers/study_session_form_controller.dart';
import '../providers/study_manager_provider.dart';

class StudySessionFormPage extends ConsumerWidget {
  const StudySessionFormPage({
    super.key,
    this.sessionId,
  });

  final String? sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (sessionId == null) {
      return const _StudySessionForm();
    }

    final sessionAsync = ref.watch(studySessionByIdProvider(sessionId!));
    return AsyncValueView<StudySession?>(
      value: sessionAsync,
      data: (session) => _StudySessionForm(initialSession: session),
    );
  }
}

class _StudySessionForm extends ConsumerStatefulWidget {
  const _StudySessionForm({this.initialSession});

  final StudySession? initialSession;

  @override
  ConsumerState<_StudySessionForm> createState() => _StudySessionFormState();
}

class _StudySessionFormState extends ConsumerState<_StudySessionForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _notesController;
  String? _selectedSubjectId;
  String? _selectedTopicId;
  late DateTime _startedAt;
  late DateTime _endedAt;

  @override
  void initState() {
    super.initState();
    final session = widget.initialSession;
    _notesController = TextEditingController(text: session?.notes ?? '');
    _selectedSubjectId = session?.studySubjectId;
    _selectedTopicId = session?.studyTopicId;
    _startedAt = session?.startedAt ?? DateTime.now();
    _endedAt = session?.endedAt ?? DateTime.now().add(const Duration(hours: 1));
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submissionState = ref.watch(studySessionFormControllerProvider);
    ref.listen<FormSubmissionState>(
      studySessionFormControllerProvider,
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
            SnackBar(content: Text(next.message ?? 'Sessao salva com sucesso.')),
          );
          Navigator.of(context).pop();
        }
      },
    );

    final subjects = ref.watch(studySubjectsProvider).valueOrNull ?? const <StudySubject>[];
    final topics = _selectedSubjectId == null
        ? const <StudyTopic>[]
        : ref.watch(studyTopicsProvider(_selectedSubjectId!)).valueOrNull ??
            const <StudyTopic>[];

    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.initialSession == null ? 'Nova sessao' : 'Editar sessao'),
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
                            setState(() {
                              _selectedSubjectId = value;
                              _selectedTopicId = null;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String?>(
                          initialValue: _selectedTopicId,
                          decoration:
                              const InputDecoration(labelText: 'Topico (opcional)'),
                          items: [
                            const DropdownMenuItem<String?>(
                              value: null,
                              child: Text('Sem topico'),
                            ),
                            ...topics.map(
                              (topic) => DropdownMenuItem<String?>(
                                value: topic.id,
                                child: Text(topic.name),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => _selectedTopicId = value);
                          },
                        ),
                        const SizedBox(height: 16),
                        _DateTimeTile(
                          title: 'Inicio',
                          value: _startedAt,
                          onTap: () async {
                            final picked = await _pickDateTime(_startedAt);
                            if (picked != null) {
                              setState(() => _startedAt = picked);
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        _DateTimeTile(
                          title: 'Fim',
                          value: _endedAt,
                          onTap: () async {
                            final picked = await _pickDateTime(_endedAt);
                            if (picked != null) {
                              setState(() => _endedAt = picked);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Duracao: ${AppFormatters.formatDuration(_duration)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _notesController,
                          minLines: 3,
                          maxLines: 5,
                          decoration:
                              const InputDecoration(labelText: 'Observacoes'),
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
                          label: const Text('Salvar sessao'),
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

  Duration get _duration {
    final difference = _endedAt.difference(_startedAt);
    return difference.isNegative ? Duration.zero : difference;
  }

  Future<DateTime?> _pickDateTime(DateTime initial) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null || !mounted) {
      return null;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );

    if (time == null) {
      return null;
    }

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> _save() async {
    if (_duration == Duration.zero) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O horario final precisa ser maior que o inicial.'),
        ),
      );
      return;
    }

    await ref.read(studySessionFormControllerProvider.notifier).submit(
          current: widget.initialSession,
          studySubjectId: _selectedSubjectId,
          studyTopicId: _selectedTopicId,
          startedAt: _startedAt,
          endedAt: _endedAt,
          durationMinutes: _duration.inMinutes,
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );
  }
}

class _DateTimeTile extends StatelessWidget {
  const _DateTimeTile({
    required this.title,
    required this.value,
    required this.onTap,
  });

  final String title;
  final DateTime value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      title: Text(title),
      subtitle: Text(
        '${AppFormatters.formatDate(value)} ${TimeOfDay.fromDateTime(value).format(context)}',
      ),
      trailing: const Icon(Icons.schedule_rounded),
      onTap: onTap,
    );
  }
}
