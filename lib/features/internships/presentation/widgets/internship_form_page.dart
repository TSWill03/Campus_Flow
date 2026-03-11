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
import '../../domain/entities/internship_record.dart';
import '../providers/internship_form_controller.dart';
import '../providers/internships_provider.dart';

class InternshipFormPage extends ConsumerWidget {
  const InternshipFormPage({
    super.key,
    this.internshipId,
  });

  final String? internshipId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (internshipId == null) {
      return const _InternshipForm();
    }

    final internshipAsync = ref.watch(internshipByIdProvider(internshipId!));
    return AsyncValueView<InternshipRecord?>(
      value: internshipAsync,
      data: (internship) => _InternshipForm(initialInternship: internship),
    );
  }
}

class _InternshipForm extends ConsumerStatefulWidget {
  const _InternshipForm({this.initialInternship});

  final InternshipRecord? initialInternship;

  @override
  ConsumerState<_InternshipForm> createState() => _InternshipFormState();
}

class _InternshipFormState extends ConsumerState<_InternshipForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _locationController;
  late final TextEditingController _supervisorController;
  late final TextEditingController _totalHoursController;
  late final TextEditingController _completedHoursController;
  late final TextEditingController _notesController;
  String? _selectedAcademicProfileId;
  late DateTime _startDate;
  DateTime? _endDate;
  late InternshipStatus _status;
  List<AttachmentDraft> _attachments = const [];
  bool _attachmentsHydrated = false;

  @override
  void initState() {
    super.initState();
    final internship = widget.initialInternship;
    _locationController = TextEditingController(text: internship?.location ?? '');
    _supervisorController =
        TextEditingController(text: internship?.supervisor ?? '');
    _totalHoursController = TextEditingController(
      text: internship?.totalHours.toString() ?? '',
    );
    _completedHoursController = TextEditingController(
      text: internship?.completedHours.toString() ?? '',
    );
    _notesController = TextEditingController(text: internship?.notes ?? '');
    _selectedAcademicProfileId = internship?.academicProfileId;
    _startDate = internship?.startDate ?? DateTime.now();
    _endDate = internship?.endDate;
    _status = internship?.status ?? InternshipStatus.planned;
  }

  @override
  void dispose() {
    _locationController.dispose();
    _supervisorController.dispose();
    _totalHoursController.dispose();
    _completedHoursController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ownerKey = (
      ownerType: AttachmentOwnerType.internshipRecord,
      ownerId: widget.initialInternship?.id ?? '',
    );
    final attachmentsAsync = widget.initialInternship == null
        ? const AsyncData<List<StoredAttachment>>([])
        : ref.watch(ownerAttachmentsProvider(ownerKey));
    final submissionState = ref.watch(internshipFormControllerProvider);
    ref.listen<FormSubmissionState>(
      internshipFormControllerProvider,
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
              content: Text(next.message ?? 'Estagio salvo com sucesso.'),
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
          widget.initialInternship?.academicProfileId ??
              ref.read(activeAcademicProfileProvider).valueOrNull?.id ??
              profiles.first.id;
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.initialInternship == null ? 'Novo estagio' : 'Editar estagio'),
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
                                'Crie um perfil academico antes de cadastrar estagios.',
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
                          controller: _locationController,
                          decoration: const InputDecoration(labelText: 'Local'),
                          validator: _required,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _supervisorController,
                          decoration:
                              const InputDecoration(labelText: 'Supervisor'),
                        ),
                        const SizedBox(height: 16),
                        _DateTile(
                          title: 'Data de inicio',
                          value: _startDate,
                          onTap: () async {
                            final picked = await _pickDate(_startDate);
                            if (picked != null) {
                              setState(() => _startDate = picked);
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        _OptionalDateTile(
                          title: 'Data de fim',
                          value: _endDate,
                          onTap: () async {
                            final picked = await _pickDate(_endDate ?? _startDate);
                            if (picked != null) {
                              setState(() => _endDate = picked);
                            }
                          },
                          onClear: _endDate == null
                              ? null
                              : () => setState(() => _endDate = null),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _totalHoursController,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: 'Carga horaria total'),
                          validator: _numberRequired,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _completedHoursController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Carga horaria cumprida',
                          ),
                          validator: _numberRequired,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<InternshipStatus>(
                          initialValue: _status,
                          decoration: const InputDecoration(labelText: 'Status'),
                          items: InternshipStatus.values
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
                          controller: _notesController,
                          minLines: 3,
                          maxLines: 5,
                          decoration:
                              const InputDecoration(labelText: 'Observacoes'),
                        ),
                        const SizedBox(height: 16),
                        AttachmentEditorSection(
                          title: 'Documentos do estagio',
                          subtitle:
                              'Anexe termo, declaracao, relatorio, certificado, ZIP, RAR ou qualquer outro arquivo relacionado ao estagio.',
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
                          label: const Text('Salvar estagio'),
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

  Future<DateTime?> _pickDate(DateTime initialDate) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(internshipFormControllerProvider.notifier).submit(
          current: widget.initialInternship,
          academicProfileId: _selectedAcademicProfileId!,
          location: _locationController.text.trim(),
          supervisor: _supervisorController.text.trim().isEmpty
              ? null
              : _supervisorController.text.trim(),
          startDate: _startDate,
          endDate: _endDate,
          totalHours: int.parse(_totalHoursController.text),
          completedHours: int.parse(_completedHoursController.text),
          status: _status,
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
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
