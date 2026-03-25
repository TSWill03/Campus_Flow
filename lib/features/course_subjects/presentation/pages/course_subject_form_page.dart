// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../../academic_profile/domain/entities/academic_profile.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../domain/entities/course_subject.dart';
import '../providers/course_subject_form_controller.dart';
import '../providers/course_subjects_provider.dart';

class CourseSubjectFormPage extends ConsumerWidget {
  const CourseSubjectFormPage({super.key, this.subjectId});

  final String? subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (subjectId == null) {
      return const _CourseSubjectForm();
    }

    final subjectAsync = ref.watch(courseSubjectByIdProvider(subjectId!));
    return AsyncValueView<CourseSubject?>(
      value: subjectAsync,
      data: (subject) => _CourseSubjectForm(initialSubject: subject),
    );
  }
}

class _CourseSubjectForm extends ConsumerStatefulWidget {
  const _CourseSubjectForm({this.initialSubject});

  final CourseSubject? initialSubject;

  @override
  ConsumerState<_CourseSubjectForm> createState() => _CourseSubjectFormState();
}

class _CourseSubjectFormState extends ConsumerState<_CourseSubjectForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _codeController;
  late final TextEditingController _workloadController;
  late final TextEditingController _electiveHoursController;
  late final TextEditingController _semesterController;
  late final TextEditingController _defaultLessonHoursController;
  late final TextEditingController _syllabusController;
  late final TextEditingController _notesController;
  late List<String> _selectedPrerequisiteSubjectIds;
  String? _selectedAcademicProfileId;
  int? _selectedScheduledWeekday;
  late CourseSubjectType _selectedType;
  late CourseSubjectStatus _selectedStatus;

  @override
  void initState() {
    super.initState();
    final subject = widget.initialSubject;
    _nameController = TextEditingController(text: subject?.name ?? '');
    _codeController = TextEditingController(text: subject?.code ?? '');
    _workloadController = TextEditingController(
      text: subject?.workloadHours.toString() ?? '',
    );
    _electiveHoursController = TextEditingController(
      text: subject?.electiveHours?.toString() ?? '',
    );
    _semesterController = TextEditingController(
      text: subject?.suggestedSemester?.toString() ?? '',
    );
    _defaultLessonHoursController = TextEditingController(
      text: subject?.defaultLessonHours?.toString().replaceAll('.', ',') ?? '',
    );
    _syllabusController = TextEditingController(text: subject?.syllabus ?? '');
    _notesController = TextEditingController(text: subject?.notes ?? '');
    _selectedPrerequisiteSubjectIds = [...?subject?.prerequisiteSubjectIds];
    _selectedAcademicProfileId = subject?.academicProfileId;
    _selectedScheduledWeekday = subject?.scheduledWeekday;
    _selectedType = subject?.type ?? CourseSubjectType.mandatory;
    _selectedStatus = subject?.status ?? CourseSubjectStatus.notStarted;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _workloadController.dispose();
    _electiveHoursController.dispose();
    _semesterController.dispose();
    _defaultLessonHoursController.dispose();
    _syllabusController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submissionState = ref.watch(courseSubjectFormControllerProvider);
    ref.listen<FormSubmissionState>(courseSubjectFormControllerProvider, (
      previous,
      next,
    ) {
      if (!mounted || previous?.status == next.status) {
        return;
      }

      if (next.isError && next.message != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message!)));
      }
    });

    final profiles =
        ref.watch(academicProfilesProvider).valueOrNull ??
        const <AcademicProfile>[];
    if (_selectedAcademicProfileId == null && profiles.isNotEmpty) {
      _selectedAcademicProfileId =
          widget.initialSubject?.academicProfileId ??
          ref.read(activeAcademicProfileProvider).valueOrNull?.id ??
          profiles.first.id;
    }
    final profileSubjects =
        ref
            .watch(
              courseSubjectsByAcademicProfileProvider(
                _selectedAcademicProfileId,
              ),
            )
            .valueOrNull ??
        const <CourseSubject>[];
    final availablePrerequisiteSubjects = profileSubjects
        .where((subject) => subject.id != widget.initialSubject?.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialSubject == null
              ? 'Nova disciplina'
              : 'Editar disciplina',
        ),
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
                        if (profiles.isEmpty)
                          Card(
                            color: Theme.of(context).colorScheme.errorContainer,
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Crie um perfil academico antes de cadastrar disciplinas.',
                              ),
                            ),
                          )
                        else
                          DropdownButtonFormField<String>(
                            initialValue: _selectedAcademicProfileId,
                            decoration: const InputDecoration(
                              labelText: 'Perfil academico',
                            ),
                            items: profiles
                                .map(
                                  (profile) => DropdownMenuItem<String>(
                                    value: profile.id,
                                    child: Text(profile.profileName),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedAcademicProfileId = value;
                                _selectedPrerequisiteSubjectIds =
                                    const <String>[];
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Selecione um perfil';
                              }
                              return null;
                            },
                          ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nome da disciplina',
                          ),
                          validator: _required,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _codeController,
                          decoration: const InputDecoration(
                            labelText: 'Codigo (opcional)',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _workloadController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Carga horaria',
                          ),
                          validator: _numberRequired,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _electiveHoursController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText:
                                'Horas optativas contabilizadas (opcional)',
                          ),
                          validator: _optionalNumber,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _semesterController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Periodo sugerido (opcional)',
                          ),
                          validator: _optionalNumber,
                        ),
                        const SizedBox(height: 16),
                        _PrerequisiteSelector(
                          availableSubjects: availablePrerequisiteSubjects,
                          selectedIds: _selectedPrerequisiteSubjectIds,
                          onPressed: profiles.isEmpty
                              ? null
                              : () => _pickPrerequisites(
                                  availablePrerequisiteSubjects,
                                ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          initialValue: _selectedScheduledWeekday,
                          decoration: const InputDecoration(
                            labelText: 'Dia fixo da semana (opcional)',
                            helperText:
                                'Se informado, o app pode lembrar voce de registrar a aula ou marcar falta no dia certo.',
                          ),
                          items: [
                            const DropdownMenuItem<int>(
                              value: null,
                              child: Text('Sem dia fixo'),
                            ),
                            ...List.generate(
                              7,
                              (index) => DropdownMenuItem<int>(
                                value: index + 1,
                                child: Text(_weekdayLabel(index + 1)),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => _selectedScheduledWeekday = value);
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _defaultLessonHoursController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Duracao padrao por aula (opcional)',
                            hintText: 'Ex.: 2 ou 1,5',
                          ),
                          validator: _defaultLessonHoursValidator,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<CourseSubjectType>(
                          initialValue: _selectedType,
                          decoration: const InputDecoration(
                            labelText: 'Tipo da disciplina',
                          ),
                          items: CourseSubjectType.values
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type.label),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedType = value);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<CourseSubjectStatus>(
                          initialValue: _selectedStatus,
                          decoration: const InputDecoration(
                            labelText: 'Status',
                          ),
                          items: CourseSubjectStatus.values
                              .map(
                                (status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status.label),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedStatus = value);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _syllabusController,
                          minLines: 4,
                          maxLines: 7,
                          decoration: const InputDecoration(
                            labelText: 'Ementa (opcional)',
                            helperText:
                                'Use este campo para guardar os conteudos oficiais da disciplina e facilitar o aproveitamento entre cursos.',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _notesController,
                          minLines: 3,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: 'Observacoes',
                          ),
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed:
                              submissionState.isLoading || profiles.isEmpty
                              ? null
                              : _save,
                          icon: submissionState.isLoading
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.save_rounded),
                          label: const Text('Salvar disciplina'),
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

  String? _numberRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatorio';
    }
    if (int.tryParse(value) == null) {
      return 'Numero invalido';
    }
    return null;
  }

  String? _optionalNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (int.tryParse(value) == null) {
      return 'Numero invalido';
    }
    return null;
  }

  String? _defaultLessonHoursValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      if (_selectedScheduledWeekday != null) {
        return 'Informe a duracao padrao da aula';
      }
      return null;
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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final savedSubject = await ref
        .read(courseSubjectFormControllerProvider.notifier)
        .submit(
          current: widget.initialSubject,
          academicProfileId: _selectedAcademicProfileId!,
          name: _nameController.text.trim(),
          code: _codeController.text.trim().isEmpty
              ? null
              : _codeController.text.trim(),
          workloadHours: int.parse(_workloadController.text),
          electiveHours: _electiveHoursController.text.trim().isEmpty
              ? null
              : int.parse(_electiveHoursController.text),
          suggestedSemester: _semesterController.text.trim().isEmpty
              ? null
              : int.parse(_semesterController.text),
          prerequisiteSubjectIds: _selectedPrerequisiteSubjectIds,
          scheduledWeekday: _selectedScheduledWeekday,
          defaultLessonHours: _defaultLessonHoursController.text.trim().isEmpty
              ? null
              : _parseHours(_defaultLessonHoursController.text),
          type: _selectedType,
          status: _selectedStatus,
          syllabus: _syllabusController.text.trim().isEmpty
              ? null
              : _syllabusController.text.trim(),
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );

    if (!mounted || savedSubject == null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.initialSubject == null
              ? 'Disciplina criada. Vamos registrar a primeira aula.'
              : 'Disciplina salva com sucesso.',
        ),
      ),
    );

    if (widget.initialSubject == null) {
      context.go('/subjects/${savedSubject.id}?startLesson=1');
      return;
    }

    Navigator.of(context).pop();
  }

  String _weekdayLabel(int weekday) {
    return const {
      1: 'Segunda-feira',
      2: 'Terca-feira',
      3: 'Quarta-feira',
      4: 'Quinta-feira',
      5: 'Sexta-feira',
      6: 'Sabado',
      7: 'Domingo',
    }[weekday]!;
  }

  Future<void> _pickPrerequisites(List<CourseSubject> availableSubjects) async {
    if (availableSubjects.isEmpty) {
      _showMessage(
        'Cadastre outras disciplinas neste perfil para usar como pre-requisito.',
      );
      return;
    }

    final initialSelection = {..._selectedPrerequisiteSubjectIds};
    final selectedIds = await showDialog<Set<String>>(
      context: context,
      builder: (context) {
        final tempSelection = {...initialSelection};
        return StatefulBuilder(
          builder: (context, setModalState) => AlertDialog(
            title: const Text('Selecionar pre-requisitos'),
            content: SizedBox(
              width: 420,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: availableSubjects
                      .map(
                        (subject) => CheckboxListTile(
                          value: tempSelection.contains(subject.id),
                          contentPadding: EdgeInsets.zero,
                          title: Text(subject.name),
                          subtitle: Text(
                            [
                              if (subject.code != null &&
                                  subject.code!.isNotEmpty)
                                subject.code!,
                              if (subject.suggestedSemester != null)
                                '${subject.suggestedSemester}o periodo',
                            ].join(' - '),
                          ),
                          onChanged: (checked) {
                            setModalState(() {
                              if (checked == true) {
                                tempSelection.add(subject.id);
                              } else {
                                tempSelection.remove(subject.id);
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(<String>{}),
                child: const Text('Limpar'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(tempSelection),
                child: const Text('Aplicar'),
              ),
            ],
          ),
        );
      },
    );

    if (!mounted || selectedIds == null) {
      return;
    }

    setState(() {
      _selectedPrerequisiteSubjectIds = selectedIds.toList();
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _PrerequisiteSelector extends StatelessWidget {
  const _PrerequisiteSelector({
    required this.availableSubjects,
    required this.selectedIds,
    required this.onPressed,
  });

  final List<CourseSubject> availableSubjects;
  final List<String> selectedIds;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final selectedSubjects = availableSubjects
        .where((subject) => selectedIds.contains(subject.id))
        .toList();

    return InputDecorator(
      decoration: const InputDecoration(
        labelText: 'Pre-requisitos (opcional)',
        helperText:
            'Selecione disciplinas que precisam estar cursadas antes desta.',
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OutlinedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.account_tree_outlined),
            label: Text(
              selectedSubjects.isEmpty
                  ? 'Selecionar pre-requisitos'
                  : 'Editar pre-requisitos',
            ),
          ),
          if (selectedSubjects.isEmpty) ...[
            const SizedBox(height: 12),
            Text(
              availableSubjects.isEmpty
                  ? 'Nenhuma outra disciplina disponivel neste perfil ainda.'
                  : 'Nenhum pre-requisito selecionado.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ] else ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedSubjects
                  .map(
                    (subject) => Chip(
                      avatar: const Icon(Icons.link_rounded, size: 18),
                      label: Text(subject.name),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
