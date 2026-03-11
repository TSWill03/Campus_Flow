import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../academic_profile/domain/entities/academic_profile.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/extension_activity.dart';
import '../providers/extension_activity_form_controller.dart';
import '../providers/extension_activities_provider.dart';

class ExtensionActivityFormPage extends ConsumerWidget {
  const ExtensionActivityFormPage({
    super.key,
    this.activityId,
  });

  final String? activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (activityId == null) {
      return const _ExtensionActivityForm();
    }

    final activityAsync = ref.watch(extensionActivityByIdProvider(activityId!));
    return AsyncValueView<ExtensionActivity?>(
      value: activityAsync,
      data: (activity) => _ExtensionActivityForm(initialActivity: activity),
    );
  }
}

class _ExtensionActivityForm extends ConsumerStatefulWidget {
  const _ExtensionActivityForm({this.initialActivity});

  final ExtensionActivity? initialActivity;

  @override
  ConsumerState<_ExtensionActivityForm> createState() =>
      _ExtensionActivityFormState();
}

class _ExtensionActivityFormState
    extends ConsumerState<_ExtensionActivityForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _typeController;
  late final TextEditingController _hoursController;
  late final TextEditingController _notesController;
  String? _selectedAcademicProfileId;
  late DateTime _selectedDate;
  late ValidationStatus _selectedStatus;

  @override
  void initState() {
    super.initState();
    final activity = widget.initialActivity;
    _titleController = TextEditingController(text: activity?.title ?? '');
    _typeController = TextEditingController(text: activity?.type ?? '');
    _hoursController = TextEditingController(
      text: activity?.workloadHours.toString() ?? '',
    );
    _notesController = TextEditingController(text: activity?.notes ?? '');
    _selectedAcademicProfileId = activity?.academicProfileId;
    _selectedDate = activity?.date ?? DateTime.now();
    _selectedStatus = activity?.status ?? ValidationStatus.pending;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _typeController.dispose();
    _hoursController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submissionState = ref.watch(extensionActivityFormControllerProvider);
    ref.listen<FormSubmissionState>(
      extensionActivityFormControllerProvider,
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
            SnackBar(
              content: Text(next.message ?? 'Atividade de extensao salva com sucesso.'),
            ),
          );
          Navigator.of(context).pop();
        }
      },
    );

    final profiles = ref.watch(academicProfilesProvider).valueOrNull ?? const <AcademicProfile>[];
    if (_selectedAcademicProfileId == null && profiles.isNotEmpty) {
      _selectedAcademicProfileId =
          widget.initialActivity?.academicProfileId ??
              ref.read(activeAcademicProfileProvider).valueOrNull?.id ??
              profiles.first.id;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialActivity == null
              ? 'Nova atividade de extensao'
              : 'Editar atividade de extensao',
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
                                'Crie um perfil academico antes de cadastrar atividades de extensao.',
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
                              setState(() => _selectedAcademicProfileId = value);
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
                          controller: _titleController,
                          decoration: const InputDecoration(labelText: 'Titulo'),
                          validator: _required,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _typeController,
                          decoration: const InputDecoration(labelText: 'Tipo'),
                          validator: _required,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _hoursController,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: 'Carga horaria'),
                          validator: _numberRequired,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          tileColor:
                              Theme.of(context).colorScheme.surfaceContainerHighest,
                          title: const Text('Data da atividade'),
                          subtitle: Text(AppFormatters.formatDate(_selectedDate)),
                          trailing: const Icon(Icons.calendar_today_rounded),
                          onTap: _pickDate,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<ValidationStatus>(
                          initialValue: _selectedStatus,
                          decoration: const InputDecoration(labelText: 'Status'),
                          items: ValidationStatus.values
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
                          controller: _notesController,
                          minLines: 3,
                          maxLines: 5,
                          decoration:
                              const InputDecoration(labelText: 'Observacao'),
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: submissionState.isLoading || profiles.isEmpty ? null : _save,
                          icon: submissionState.isLoading
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.save_rounded),
                          label: const Text('Salvar atividade'),
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

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(extensionActivityFormControllerProvider.notifier).submit(
          current: widget.initialActivity,
          academicProfileId: _selectedAcademicProfileId!,
          title: _titleController.text.trim(),
          type: _typeController.text.trim(),
          date: _selectedDate,
          workloadHours: int.parse(_hoursController.text),
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
          status: _selectedStatus,
        );
  }
}
