import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/async_value_view.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../domain/entities/academic_profile.dart';
import '../providers/academic_profile_form_controller.dart';
import '../providers/academic_profile_provider.dart';

class AcademicProfileFormPage extends ConsumerWidget {
  const AcademicProfileFormPage({
    super.key,
    this.profileId,
  });

  final String? profileId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (profileId == null) {
      return const _AcademicProfileForm();
    }

    final profileAsync = ref.watch(academicProfileByIdProvider(profileId!));
    return AsyncValueView<AcademicProfile?>(
      value: profileAsync,
      data: (profile) => _AcademicProfileForm(initialProfile: profile),
    );
  }
}

class _AcademicProfileForm extends ConsumerStatefulWidget {
  const _AcademicProfileForm({this.initialProfile});

  final AcademicProfile? initialProfile;

  @override
  ConsumerState<_AcademicProfileForm> createState() => _AcademicProfileFormState();
}

class _AcademicProfileFormState extends ConsumerState<_AcademicProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _profileNameController;
  late final TextEditingController _institutionController;
  late final TextEditingController _schoolNameController;
  late final TextEditingController _campusController;
  late final TextEditingController _degreeLabelController;
  late final TextEditingController _courseNameController;
  late final TextEditingController _totalHoursController;
  late final TextEditingController _semesterCountController;
  late final TextEditingController _complementaryHoursController;
  late final TextEditingController _internshipHoursController;
  late final TextEditingController _extensionHoursController;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    final profile = widget.initialProfile;
    final hasActiveProfile = ref.read(activeAcademicProfileProvider).valueOrNull != null;
    _profileNameController =
        TextEditingController(text: profile?.profileName ?? profile?.courseName ?? '');
    _institutionController =
        TextEditingController(text: profile?.institution ?? '');
    _schoolNameController = TextEditingController(text: profile?.schoolName ?? '');
    _campusController = TextEditingController(text: profile?.campus ?? '');
    _degreeLabelController =
        TextEditingController(text: profile?.degreeLabel ?? '');
    _courseNameController = TextEditingController(text: profile?.courseName ?? '');
    _totalHoursController = TextEditingController(
      text: profile?.totalCourseHours.toString() ?? '',
    );
    _semesterCountController = TextEditingController(
      text: profile?.semesterCount.toString() ?? '',
    );
    _complementaryHoursController = TextEditingController(
      text: profile?.requiredComplementaryHours.toString() ?? '',
    );
    _internshipHoursController = TextEditingController(
      text: profile?.requiredInternshipHours.toString() ?? '',
    );
    _extensionHoursController = TextEditingController(
      text: profile?.requiredExtensionHours.toString() ?? '',
    );
    _isActive = profile?.isActive ?? !hasActiveProfile;
  }

  @override
  void dispose() {
    _profileNameController.dispose();
    _institutionController.dispose();
    _schoolNameController.dispose();
    _campusController.dispose();
    _degreeLabelController.dispose();
    _courseNameController.dispose();
    _totalHoursController.dispose();
    _semesterCountController.dispose();
    _complementaryHoursController.dispose();
    _internshipHoursController.dispose();
    _extensionHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submissionState = ref.watch(academicProfileFormControllerProvider);
    ref.listen<FormSubmissionState>(
      academicProfileFormControllerProvider,
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
              content: Text(next.message ?? 'Perfil academico salvo com sucesso.'),
            ),
          );
          Navigator.of(context).pop();
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialProfile == null ? 'Novo perfil academico' : 'Editar perfil academico',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
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
                          controller: _profileNameController,
                          decoration: const InputDecoration(
                            labelText: 'Nome do perfil',
                            hintText: 'Ex.: UFRJ Medicina, USP Mestrado, MBA',
                          ),
                          validator: _required,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            _TextFieldBox(
                              controller: _institutionController,
                              label: 'Universidade / instituicao',
                            ),
                            _TextFieldBox(
                              controller: _schoolNameController,
                              label: 'Faculdade / escola',
                            ),
                            _TextFieldBox(
                              controller: _campusController,
                              label: 'Campus',
                            ),
                            _TextFieldBox(
                              controller: _degreeLabelController,
                              label: 'Nivel / titulacao',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _courseNameController,
                          decoration: const InputDecoration(labelText: 'Curso'),
                          validator: _required,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            _NumberField(
                              controller: _totalHoursController,
                              label: 'Carga horaria total',
                            ),
                            _NumberField(
                              controller: _semesterCountController,
                              label: 'Quantidade de semestres',
                            ),
                            _NumberField(
                              controller: _complementaryHoursController,
                              label: 'Horas complementares obrigatorias',
                            ),
                            _NumberField(
                              controller: _internshipHoursController,
                              label: 'Horas de estagio obrigatorias',
                            ),
                            _NumberField(
                              controller: _extensionHoursController,
                              label: 'Horas de extensao obrigatorias',
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile.adaptive(
                          value: _isActive,
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Usar como perfil academico ativo'),
                          subtitle: const Text(
                            'Listas e dashboard academico serao filtrados por este perfil.',
                          ),
                          onChanged: (value) {
                            setState(() => _isActive = value);
                          },
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton.icon(
                            onPressed: submissionState.isLoading ? null : _save,
                            icon: submissionState.isLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Icon(Icons.save_rounded),
                            label: const Text('Salvar perfil'),
                          ),
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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref.read(academicProfileFormControllerProvider.notifier).submit(
          current: widget.initialProfile,
          profileName: _profileNameController.text.trim(),
          institution: _institutionController.text.trim(),
          schoolName: _schoolNameController.text.trim().isEmpty
              ? null
              : _schoolNameController.text.trim(),
          campus: _campusController.text.trim().isEmpty
              ? null
              : _campusController.text.trim(),
          degreeLabel: _degreeLabelController.text.trim().isEmpty
              ? null
              : _degreeLabelController.text.trim(),
          courseName: _courseNameController.text.trim(),
          totalCourseHours: int.parse(_totalHoursController.text),
          semesterCount: int.parse(_semesterCountController.text),
          requiredComplementaryHours: int.parse(_complementaryHoursController.text),
          requiredInternshipHours: int.parse(_internshipHoursController.text),
          requiredExtensionHours: int.parse(_extensionHoursController.text),
          isActive: _isActive,
        );
  }
}

class _TextFieldBox extends StatelessWidget {
  const _TextFieldBox({
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.controller,
    required this.label,
  });

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Informe um valor';
          }

          if (int.tryParse(value) == null) {
            return 'Numero invalido';
          }

          return null;
        },
      ),
    );
  }
}
