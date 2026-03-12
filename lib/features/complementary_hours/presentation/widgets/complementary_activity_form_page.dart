// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/attachments/attachment_category.dart';
import '../../../../core/attachments/attachment_draft.dart';
import '../../../../core/attachments/attachment_owner_type.dart';
import '../../../../core/attachments/attachment_providers.dart';
import '../../../../core/attachments/stored_attachment.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/attachment_editor_section.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../../academic_profile/domain/entities/academic_profile.dart';
import '../../../academic_profile/presentation/providers/academic_profile_provider.dart';
import '../../domain/entities/complementary_activity.dart';
import '../providers/complementary_activities_provider.dart';
import '../providers/complementary_activity_form_controller.dart';

class ComplementaryActivityFormPage extends ConsumerWidget {
  const ComplementaryActivityFormPage({
    super.key,
    this.activityId,
  });

  final String? activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (activityId == null) {
      return const _ComplementaryActivityForm();
    }

    final activityAsync = ref.watch(complementaryActivityByIdProvider(activityId!));
    return AsyncValueView<ComplementaryActivity?>(
      value: activityAsync,
      data: (activity) => _ComplementaryActivityForm(initialActivity: activity),
    );
  }
}

class _ComplementaryActivityForm extends ConsumerStatefulWidget {
  const _ComplementaryActivityForm({this.initialActivity});

  final ComplementaryActivity? initialActivity;

  @override
  ConsumerState<_ComplementaryActivityForm> createState() =>
      _ComplementaryActivityFormState();
}

class _ComplementaryActivityFormState
    extends ConsumerState<_ComplementaryActivityForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _categoryController;
  late final TextEditingController _hoursController;
  late final TextEditingController _notesController;
  String? _selectedAcademicProfileId;
  late DateTime _selectedStartDate;
  DateTime? _selectedEndDate;
  late ValidationStatus _selectedStatus;
  List<AttachmentDraft> _attachments = const [];
  bool _attachmentsHydrated = false;

  @override
  void initState() {
    super.initState();
    final activity = widget.initialActivity;
    _titleController = TextEditingController(text: activity?.title ?? '');
    _categoryController = TextEditingController(text: activity?.category ?? '');
    _hoursController = TextEditingController(
      text: activity?.workloadHours.toString() ?? '',
    );
    _notesController = TextEditingController(text: activity?.notes ?? '');
    _selectedAcademicProfileId = activity?.academicProfileId;
    _selectedStartDate = activity?.date ?? DateTime.now();
    _selectedEndDate = activity?.endDate;
    _selectedStatus = activity?.status ?? ValidationStatus.pending;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _hoursController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ownerKey = (
      ownerType: AttachmentOwnerType.complementaryActivity,
      ownerId: widget.initialActivity?.id ?? '',
    );
    final attachmentsAsync = widget.initialActivity == null
        ? const AsyncData<List<StoredAttachment>>([])
        : ref.watch(ownerAttachmentsProvider(ownerKey));
    final submissionState = ref.watch(complementaryActivityFormControllerProvider);
    ref.listen<FormSubmissionState>(
      complementaryActivityFormControllerProvider,
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
              content: Text(next.message ?? 'Atividade complementar salva com sucesso.'),
            ),
          );
          Navigator.of(context).pop();
        }
      },
    );

    if (!_attachmentsHydrated) {
      final storedAttachments = attachmentsAsync.valueOrNull;
      if (storedAttachments != null) {
        _attachments = storedAttachments.map(_draftFromStored).toList();
        _attachmentsHydrated = true;
      }
    }

    final profiles =
        ref.watch(academicProfilesProvider).valueOrNull ?? const <AcademicProfile>[];
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
              ? 'Nova atividade complementar'
              : 'Editar atividade complementar',
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
                                'Crie um perfil academico antes de cadastrar atividades complementares.',
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
                          controller: _categoryController,
                          decoration: const InputDecoration(labelText: 'Categoria'),
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
                        _DateTile(
                          title: 'Data inicial',
                          value: _selectedStartDate,
                          onTap: _pickStartDate,
                        ),
                        const SizedBox(height: 12),
                        _OptionalDateTile(
                          title: 'Data final (atividade continua)',
                          value: _selectedEndDate,
                          onTap: _pickEndDate,
                          onClear: _selectedEndDate == null
                              ? null
                              : () => setState(() => _selectedEndDate = null),
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
                        const SizedBox(height: 16),
                        AttachmentEditorSection(
                          title: 'Certificados e comprovantes',
                          subtitle:
                              'Anexe certificado, declaracao, documento, ZIP, RAR ou qualquer outro arquivo da atividade.',
                          attachments: _attachments,
                          allowedCategories: const [
                            AttachmentCategory.certificate,
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
                          onPressed: submissionState.isLoading || profiles.isEmpty
                              ? null
                              : _save,
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

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedStartDate = picked);
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate ?? _selectedStartDate,
      firstDate: _selectedStartDate,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedEndDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(complementaryActivityFormControllerProvider.notifier).submit(
          current: widget.initialActivity,
          academicProfileId: _selectedAcademicProfileId!,
          title: _titleController.text.trim(),
          category: _categoryController.text.trim(),
          date: _selectedStartDate,
          endDate: _selectedEndDate,
          workloadHours: int.parse(_hoursController.text),
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
          status: _selectedStatus,
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
    );
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile({
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
      subtitle: Text(AppFormatters.formatDate(value)),
      trailing: const Icon(Icons.calendar_today_rounded),
      onTap: onTap,
    );
  }
}

class _OptionalDateTile extends StatelessWidget {
  const _OptionalDateTile({
    required this.title,
    required this.value,
    required this.onTap,
    this.onClear,
  });

  final String title;
  final DateTime? value;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      title: Text(title),
      subtitle: Text(AppFormatters.formatDate(value)),
      trailing: Wrap(
        spacing: 4,
        children: [
          if (onClear != null)
            IconButton(
              onPressed: onClear,
              icon: const Icon(Icons.close_rounded),
            ),
          const Icon(Icons.calendar_today_rounded),
        ],
      ),
      onTap: onTap,
    );
  }
}
