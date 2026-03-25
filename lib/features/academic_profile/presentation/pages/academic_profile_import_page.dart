// Signature: dev.tswicolly03

import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../../../course_subjects/presentation/providers/course_subjects_provider.dart';
import '../../data/services/course_subject_equivalence_analyzer.dart';
import '../../data/services/curriculum_document_reader.dart';
import '../../data/services/curriculum_file_loader.dart';
import '../../data/services/curriculum_import_parser.dart';
import '../../domain/entities/academic_profile.dart';
import '../../domain/entities/curriculum_import_preview.dart';
import '../../domain/entities/curriculum_import_subject_draft.dart';
import '../../domain/entities/subject_equivalence_suggestion.dart';
import '../providers/academic_profile_provider.dart';
import '../providers/curriculum_import_controller.dart';

class AcademicProfileImportPage extends ConsumerStatefulWidget {
  const AcademicProfileImportPage({super.key});

  @override
  ConsumerState<AcademicProfileImportPage> createState() =>
      _AcademicProfileImportPageState();
}

class _AcademicProfileImportPageState
    extends ConsumerState<AcademicProfileImportPage> {
  static const _editorPreviewCharacterLimit = 12000;

  final _formKey = GlobalKey<FormState>();
  final _rawTextController = TextEditingController();
  final _profileNameController = TextEditingController();
  final _institutionController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _campusController = TextEditingController();
  final _degreeLabelController = TextEditingController();
  final _courseNameController = TextEditingController();
  final _totalHoursController = TextEditingController();
  final _semesterCountController = TextEditingController();
  final _complementaryHoursController = TextEditingController();
  final _internshipHoursController = TextEditingController();
  final _extensionHoursController = TextEditingController();

  Timer? _equivalenceDebounce;
  CurriculumImportPreview? _preview;
  String? _selectedFileName;
  String? _loadedFileText;
  String? _selectedExistingProfileId;
  bool _isParsing = false;
  bool _isAnalyzingEquivalences = false;
  bool _makeActive = true;
  bool _removeMissingSubjectsOnUpdate = false;
  bool _useLoadedFileTextForParse = false;
  int _equivalenceRequestId = 0;
  _CurriculumImportTargetMode _targetMode =
      _CurriculumImportTargetMode.newProfile;
  Map<String, List<SubjectEquivalenceSuggestion>>
  _equivalenceSuggestionsByLocalId =
      const <String, List<SubjectEquivalenceSuggestion>>{};

  @override
  void dispose() {
    _equivalenceDebounce?.cancel();
    _rawTextController.dispose();
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
    final submissionState = ref.watch(curriculumImportControllerProvider);
    final profiles =
        ref.watch(academicProfilesProvider).valueOrNull ??
        const <AcademicProfile>[];
    final activeProfileId = ref
        .watch(activeAcademicProfileProvider)
        .valueOrNull
        ?.id;
    if (_selectedExistingProfileId == null && profiles.isNotEmpty) {
      _selectedExistingProfileId = activeProfileId ?? profiles.first.id;
    }
    ref.listen<FormSubmissionState>(curriculumImportControllerProvider, (
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

      if (next.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? 'Grade importada com sucesso.'),
          ),
        );
        Navigator.of(context).pop();
      }
    });

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Importar grade do curso')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cole a grade, ementa ou PPC do curso',
                              style: theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'O parser procura instituicao, curso, carga horaria total, horas obrigatorias e disciplinas. Voce pode colar texto ou carregar arquivo de texto e PDF. Depois revisa tudo antes de salvar.',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _rawTextController,
                              minLines: 12,
                              maxLines: 18,
                              onChanged: (_) {
                                if (_useLoadedFileTextForParse) {
                                  setState(
                                    () => _useLoadedFileTextForParse = false,
                                  );
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: 'Texto da grade, ementa ou PPC',
                                alignLabelWithHint: true,
                                hintText:
                                    'Cole aqui a grade curricular, ementa geral, matriz ou texto extraido do PPC.',
                              ),
                              validator: (value) {
                                if (_preview != null) {
                                  return null;
                                }
                                if (_resolveInputText().isEmpty) {
                                  return 'Cole algum texto antes de interpretar';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: _isParsing
                                      ? null
                                      : _pickCurriculumFile,
                                  icon: const Icon(Icons.upload_file_rounded),
                                  label: const Text('Carregar arquivo ou PDF'),
                                ),
                                FilledButton.icon(
                                  onPressed: _isParsing
                                      ? null
                                      : _parseCurriculum,
                                  icon: _isParsing
                                      ? const SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(Icons.auto_awesome_rounded),
                                  label: const Text('Interpretar grade'),
                                ),
                              ],
                            ),
                            if (_selectedFileName != null) ...[
                              const SizedBox(height: 12),
                              Text(
                                'Arquivo carregado: $_selectedFileName',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              if (_useLoadedFileTextForParse &&
                                  _rawTextController.text.isEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'O texto extraido do arquivo sera usado na interpretacao sem abrir no editor para evitar travamentos com documentos longos.',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ),
                    if (_preview != null) ...[
                      const SizedBox(height: 24),
                      _buildProfileCard(theme, profiles),
                      const SizedBox(height: 24),
                      _buildSubjectsCard(theme),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton.icon(
                          onPressed: submissionState.isLoading
                              ? null
                              : _importCurriculum,
                          icon: submissionState.isLoading
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.save_rounded),
                          label: Text(
                            _targetMode ==
                                    _CurriculumImportTargetMode.updateExisting
                                ? 'Atualizar perfil'
                                : 'Importar grade',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(ThemeData theme, List<AcademicProfile> profiles) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Revisao do perfil academico',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Ajuste os campos antes de criar o perfil e importar as disciplinas.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (profiles.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Destino da importacao', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              SegmentedButton<_CurriculumImportTargetMode>(
                segments: const [
                  ButtonSegment<_CurriculumImportTargetMode>(
                    value: _CurriculumImportTargetMode.newProfile,
                    icon: Icon(Icons.add_card_rounded),
                    label: Text('Novo perfil'),
                  ),
                  ButtonSegment<_CurriculumImportTargetMode>(
                    value: _CurriculumImportTargetMode.updateExisting,
                    icon: Icon(Icons.sync_alt_rounded),
                    label: Text('Atualizar existente'),
                  ),
                ],
                selected: {_targetMode},
                onSelectionChanged: (selection) {
                  setState(() {
                    _targetMode = selection.first;
                    if (_targetMode ==
                            _CurriculumImportTargetMode.updateExisting &&
                        _selectedExistingProfileId == null &&
                        profiles.isNotEmpty) {
                      _selectedExistingProfileId = profiles.first.id;
                    }
                  });
                  _scheduleEquivalenceRefresh();
                },
              ),
              const SizedBox(height: 12),
              if (_targetMode == _CurriculumImportTargetMode.updateExisting)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _selectedExistingProfileId,
                      decoration: const InputDecoration(
                        labelText: 'Perfil existente',
                        helperText:
                            'Disciplinas serao reaproveitadas por codigo ou nome. O que nao existir ainda sera criado.',
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
                        setState(() => _selectedExistingProfileId = value);
                        _scheduleEquivalenceRefresh();
                      },
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile.adaptive(
                      value: _removeMissingSubjectsOnUpdate,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Remover disciplinas antigas que nao estao no novo PPC',
                      ),
                      subtitle: const Text(
                        'Use quando a nova grade substitui a antiga. Disciplinas nao reconhecidas na importacao serao excluidas desse perfil.',
                      ),
                      onChanged: (value) {
                        setState(() => _removeMissingSubjectsOnUpdate = value);
                      },
                    ),
                  ],
                ),
            ],
            const SizedBox(height: 16),
            TextFormField(
              controller: _profileNameController,
              decoration: const InputDecoration(labelText: 'Nome do perfil'),
              validator: _required,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _ProfileFieldBox(
                  controller: _institutionController,
                  label: 'Universidade / instituicao',
                  validator: _required,
                ),
                _ProfileFieldBox(
                  controller: _schoolNameController,
                  label: 'Faculdade / escola',
                ),
                _ProfileFieldBox(
                  controller: _campusController,
                  label: 'Campus',
                ),
                _ProfileFieldBox(
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
                _ProfileFieldBox(
                  controller: _totalHoursController,
                  label: 'Carga horaria total',
                  validator: _requiredNumber,
                  keyboardType: TextInputType.number,
                ),
                _ProfileFieldBox(
                  controller: _semesterCountController,
                  label: 'Quantidade de semestres',
                  validator: _requiredNumber,
                  keyboardType: TextInputType.number,
                ),
                _ProfileFieldBox(
                  controller: _complementaryHoursController,
                  label: 'Horas complementares obrigatorias',
                  validator: _requiredNumber,
                  keyboardType: TextInputType.number,
                ),
                _ProfileFieldBox(
                  controller: _internshipHoursController,
                  label: 'Horas de estagio obrigatorias',
                  validator: _requiredNumber,
                  keyboardType: TextInputType.number,
                ),
                _ProfileFieldBox(
                  controller: _extensionHoursController,
                  label: 'Horas de extensao obrigatorias',
                  validator: _requiredNumber,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile.adaptive(
              value: _makeActive,
              contentPadding: EdgeInsets.zero,
              title: const Text('Tornar este perfil ativo'),
              subtitle: const Text(
                'O dashboard e as listas academicas passarao a usar esse perfil por padrao.',
              ),
              onChanged: (value) {
                setState(() => _makeActive = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectsCard(ThemeData theme) {
    final preview = _preview!;
    final subjectsWithPrerequisites = preview.subjects
        .where((subject) => subject.prerequisiteLocalIds.isNotEmpty)
        .length;
    final subjectsWithSuggestions = _equivalenceSuggestionsByLocalId.values
        .where((suggestions) => suggestions.isNotEmpty)
        .length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Disciplinas encontradas',
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${preview.subjects.length} disciplinas prontas para revisar e importar.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (subjectsWithPrerequisites > 0) ...[
                        const SizedBox(height: 6),
                        Text(
                          '$subjectsWithPrerequisites disciplina(s) com pre-requisitos reconhecidos automaticamente.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      if (_isAnalyzingEquivalences) ...[
                        const SizedBox(height: 10),
                        const LinearProgressIndicator(),
                      ] else if (subjectsWithSuggestions > 0) ...[
                        const SizedBox(height: 6),
                        Text(
                          '$subjectsWithSuggestions disciplina(s) com sugestoes de aproveitamento em outros perfis.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.tertiary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                FilledButton.icon(
                  onPressed: _addSubject,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Adicionar materia'),
                ),
              ],
            ),
            if (preview.notes.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Observacoes da leitura automatica',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ...preview.notes.map(
                      (note) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(note),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            if (preview.subjects.isEmpty)
              Text(
                'Nenhuma disciplina foi identificada automaticamente. Use o botao acima para adicionar manualmente.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            else
              ...preview.subjects.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _SubjectDraftCard(
                    key: ValueKey(entry.value.localId),
                    index: entry.key,
                    subject: entry.value,
                    allSubjects: preview.subjects,
                    suggestions:
                        _equivalenceSuggestionsByLocalId[entry.value.localId] ??
                        const <SubjectEquivalenceSuggestion>[],
                    onChanged: (updated) => _updateSubject(entry.key, updated),
                    onRemove: () => _removeSubject(entry.key),
                  ),
                ),
              ),
          ],
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

  String? _requiredNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe um valor';
    }
    if (int.tryParse(value.trim()) == null) {
      return 'Numero invalido';
    }
    return null;
  }

  Future<void> _pickCurriculumFile() async {
    setState(() => _isParsing = true);
    try {
      final result = await FilePicker.platform.pickFiles(
        withData: kIsWeb,
        type: FileType.custom,
        allowedExtensions: const ['txt', 'md', 'csv', 'html', 'htm', 'pdf'],
      );
      if (result == null || result.files.isEmpty) {
        return;
      }

      final file = result.files.single;
      final bytes = await readCurriculumFileBytes(file);
      if (bytes.isEmpty) {
        _showMessage(
          'Nao foi possivel ler o arquivo. Tente um arquivo de texto ou cole o conteudo manualmente.',
        );
        return;
      }

      final decoded = await ref
          .read(curriculumDocumentReaderProvider)
          .extractText(bytes: bytes, fileName: file.name);
      if (!mounted) {
        return;
      }
      final shouldPreviewInEditor =
          decoded.length <= _editorPreviewCharacterLimit;
      setState(() {
        _loadedFileText = decoded;
        _useLoadedFileTextForParse = true;
        _rawTextController.text = shouldPreviewInEditor ? decoded : '';
        _selectedFileName = file.name;
        _preview = null;
        _equivalenceSuggestionsByLocalId =
            const <String, List<SubjectEquivalenceSuggestion>>{};
      });
      if (!shouldPreviewInEditor) {
        _showMessage(
          'Arquivo carregado. O texto extraido sera usado na interpretacao sem abrir no editor para evitar travamentos.',
        );
      }
    } catch (error) {
      _showMessage('Nao foi possivel carregar o arquivo: $error');
    } finally {
      if (mounted) {
        setState(() => _isParsing = false);
      }
    }
  }

  Future<void> _parseCurriculum() async {
    final rawText = _resolveInputText();
    if (rawText.isEmpty) {
      _showMessage('Cole a grade ou carregue um arquivo antes de interpretar.');
      return;
    }

    setState(() => _isParsing = true);
    try {
      final preview = ref.read(curriculumImportParserProvider).parse(rawText);
      _syncFormWithPreview(preview);
      setState(() {
        _preview = preview;
      });
      await _refreshEquivalenceSuggestions(preview);
    } catch (error) {
      _showMessage('Nao foi possivel interpretar a grade: $error');
    } finally {
      if (mounted) {
        setState(() => _isParsing = false);
      }
    }
  }

  void _syncFormWithPreview(CurriculumImportPreview preview) {
    _profileNameController.text = preview.profileName;
    _institutionController.text = preview.institution;
    _schoolNameController.text = preview.schoolName ?? '';
    _campusController.text = preview.campus ?? '';
    _degreeLabelController.text = preview.degreeLabel ?? '';
    _courseNameController.text = preview.courseName;
    _totalHoursController.text = preview.totalCourseHours.toString();
    _semesterCountController.text = preview.semesterCount.toString();
    _complementaryHoursController.text = preview.requiredComplementaryHours
        .toString();
    _internshipHoursController.text = preview.requiredInternshipHours
        .toString();
    _extensionHoursController.text = preview.requiredExtensionHours.toString();
    _makeActive = preview.makeActive;
  }

  void _scheduleEquivalenceRefresh() {
    _equivalenceDebounce?.cancel();
    final preview = _preview;
    if (preview == null) {
      return;
    }

    _equivalenceDebounce = Timer(const Duration(milliseconds: 300), () {
      _refreshEquivalenceSuggestions(preview);
    });
  }

  Future<void> _refreshEquivalenceSuggestions(
    CurriculumImportPreview preview,
  ) async {
    final requestId = ++_equivalenceRequestId;
    if (mounted) {
      setState(() => _isAnalyzingEquivalences = true);
    }

    final profiles =
        ref.read(academicProfilesProvider).valueOrNull ??
        const <AcademicProfile>[];
    final existingSubjects = await ref
        .read(courseSubjectRepositoryProvider)
        .getAllSubjects();

    final suggestions = ref
        .read(courseSubjectEquivalenceAnalyzerProvider)
        .analyze(
          importedSubjects: preview.subjects,
          existingProfiles: profiles,
          existingSubjects: existingSubjects,
          excludedProfileId:
              _targetMode == _CurriculumImportTargetMode.updateExisting
              ? _selectedExistingProfileId
              : null,
        );

    if (!mounted || requestId != _equivalenceRequestId) {
      return;
    }

    setState(() {
      _equivalenceSuggestionsByLocalId = suggestions;
      _isAnalyzingEquivalences = false;
    });
  }

  void _addSubject() {
    final preview = _preview;
    if (preview == null) {
      return;
    }

    setState(() {
      _preview = preview.copyWith(
        subjects: [
          ...preview.subjects,
          CurriculumImportSubjectDraft(
            localId: DateTime.now().microsecondsSinceEpoch.toString(),
            name: '',
            code: null,
            workloadHours: 0,
            suggestedSemester: null,
            type: CourseSubjectType.mandatory,
            prerequisiteLocalIds: const <String>[],
            syllabus: null,
            notes: null,
          ),
        ],
      );
    });
    _scheduleEquivalenceRefresh();
  }

  void _updateSubject(int index, CurriculumImportSubjectDraft updated) {
    final preview = _preview;
    if (preview == null) {
      return;
    }

    final subjects = [...preview.subjects];
    subjects[index] = updated;
    setState(() {
      _preview = preview.copyWith(subjects: subjects);
    });
    _scheduleEquivalenceRefresh();
  }

  void _removeSubject(int index) {
    final preview = _preview;
    if (preview == null) {
      return;
    }

    final subjects = [...preview.subjects]..removeAt(index);
    setState(() {
      _preview = preview.copyWith(subjects: subjects);
    });
    _scheduleEquivalenceRefresh();
  }

  Future<void> _importCurriculum() async {
    final preview = _preview;
    if (preview == null) {
      _showMessage('Interprete a grade antes de importar.');
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (preview.subjects.isEmpty) {
      _showMessage('Adicione pelo menos uma disciplina antes de importar.');
      return;
    }

    final updatedPreview = preview.copyWith(
      profileName: _profileNameController.text.trim(),
      institution: _institutionController.text.trim(),
      schoolName: _nullIfBlank(_schoolNameController.text),
      campus: _nullIfBlank(_campusController.text),
      degreeLabel: _nullIfBlank(_degreeLabelController.text),
      courseName: _courseNameController.text.trim(),
      totalCourseHours: int.parse(_totalHoursController.text.trim()),
      semesterCount: int.parse(_semesterCountController.text.trim()),
      requiredComplementaryHours: int.parse(
        _complementaryHoursController.text.trim(),
      ),
      requiredInternshipHours: int.parse(
        _internshipHoursController.text.trim(),
      ),
      requiredExtensionHours: int.parse(_extensionHoursController.text.trim()),
      makeActive: _makeActive,
    );

    final targetProfileId =
        _targetMode == _CurriculumImportTargetMode.updateExisting
        ? _selectedExistingProfileId
        : null;
    if (_targetMode == _CurriculumImportTargetMode.updateExisting &&
        (targetProfileId == null || targetProfileId.isEmpty)) {
      _showMessage('Selecione o perfil que deve ser atualizado.');
      return;
    }

    await ref
        .read(curriculumImportControllerProvider.notifier)
        .importCurriculum(
          updatedPreview,
          targetProfileId: targetProfileId,
          removeMissingSubjects:
              _targetMode == _CurriculumImportTargetMode.updateExisting &&
              _removeMissingSubjectsOnUpdate,
        );
  }

  String? _nullIfBlank(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  String _resolveInputText() {
    if (_useLoadedFileTextForParse) {
      return (_loadedFileText ?? '').trim();
    }
    return _rawTextController.text.trim();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _ProfileFieldBox extends StatelessWidget {
  const _ProfileFieldBox({
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }
}

class _SubjectDraftCard extends StatelessWidget {
  const _SubjectDraftCard({
    super.key,
    required this.index,
    required this.subject,
    required this.allSubjects,
    required this.suggestions,
    required this.onChanged,
    required this.onRemove,
  });

  final int index;
  final CurriculumImportSubjectDraft subject;
  final List<CurriculumImportSubjectDraft> allSubjects;
  final List<SubjectEquivalenceSuggestion> suggestions;
  final ValueChanged<CurriculumImportSubjectDraft> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final subjectNameByLocalId = {
      for (final candidate in allSubjects) candidate.localId: candidate.name,
    };
    final prerequisiteNames = subject.prerequisiteLocalIds
        .map((localId) => subjectNameByLocalId[localId])
        .whereType<String>()
        .where((name) => name.trim().isNotEmpty)
        .toList();
    SubjectEquivalenceSuggestion? selectedSuggestion;
    for (final suggestion in suggestions) {
      if (suggestion.existingSubjectId == subject.creditSourceSubjectId &&
          suggestion.existingProfileId == subject.creditSourceProfileId) {
        selectedSuggestion = suggestion;
        break;
      }
    }

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Materia ${index + 1}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  tooltip: 'Remover materia',
                  icon: const Icon(Icons.delete_outline_rounded),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: subject.name,
              decoration: const InputDecoration(
                labelText: 'Nome da disciplina',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Informe o nome da disciplina';
                }
                return null;
              },
              onChanged: (value) => onChanged(subject.copyWith(name: value)),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                SizedBox(
                  width: 220,
                  child: TextFormField(
                    initialValue: subject.code ?? '',
                    decoration: const InputDecoration(
                      labelText: 'Codigo (opcional)',
                    ),
                    onChanged: (value) => onChanged(
                      subject.copyWith(
                        code: value.trim().isEmpty ? null : value.trim(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 180,
                  child: TextFormField(
                    initialValue: subject.workloadHours == 0
                        ? ''
                        : subject.workloadHours.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Carga horaria',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe a carga';
                      }
                      if (int.tryParse(value.trim()) == null) {
                        return 'Numero invalido';
                      }
                      return null;
                    },
                    onChanged: (value) => onChanged(
                      subject.copyWith(
                        workloadHours: int.tryParse(value.trim()) ?? 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    initialValue: subject.suggestedSemester?.toString() ?? '',
                    decoration: const InputDecoration(
                      labelText: 'Periodo sugerido',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return null;
                      }
                      if (int.tryParse(value.trim()) == null) {
                        return 'Numero invalido';
                      }
                      return null;
                    },
                    onChanged: (value) => onChanged(
                      subject.copyWith(
                        suggestedSemester: value.trim().isEmpty
                            ? null
                            : int.tryParse(value.trim()),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: DropdownButtonFormField<CourseSubjectType>(
                    initialValue: subject.type,
                    decoration: const InputDecoration(labelText: 'Tipo'),
                    items: CourseSubjectType.values
                        .map(
                          (type) => DropdownMenuItem<CourseSubjectType>(
                            value: type,
                            child: Text(type.label),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        onChanged(subject.copyWith(type: value));
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (prerequisiteNames.isNotEmpty) ...[
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Pre-requisitos importados',
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: prerequisiteNames
                      .map(
                        (name) => Chip(
                          avatar: const Icon(
                            Icons.account_tree_outlined,
                            size: 18,
                          ),
                          label: Text(name),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              initialValue: subject.syllabus ?? '',
              minLines: 3,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Ementa (opcional)',
                helperText:
                    'Quanto mais completa a ementa, melhor fica a comparacao para aproveitamento entre cursos.',
              ),
              onChanged: (value) => onChanged(
                subject.copyWith(
                  syllabus: value.trim().isEmpty ? null : value.trim(),
                ),
              ),
            ),
            if (subject.creditStatus != CourseSubjectCreditStatus.none &&
                subject.creditSourceSubjectId != null &&
                subject.creditSourceProfileId != null) ...[
              const SizedBox(height: 16),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Aproveitamento marcado',
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedSuggestion?.existingSubjectName ??
                          'Disciplina de origem vinculada',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (selectedSuggestion != null)
                          Chip(label: Text(selectedSuggestion.existingProfileName)),
                        Chip(label: Text(subject.creditStatus.label)),
                        if (subject.creditMatchScore != null)
                          Chip(
                            label: Text(
                              'Compatibilidade ${_formatPercent(subject.creditMatchScore!)}',
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subject.creditStatus == CourseSubjectCreditStatus.requested
                          ? 'Essa disciplina nova sera importada ja marcada como aproveitamento solicitado.'
                          : 'O aproveitamento desta disciplina ja foi marcado durante a revisao.',
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () => onChanged(
                        subject.copyWith(
                          creditSourceSubjectId: null,
                          creditSourceProfileId: null,
                          creditStatus: CourseSubjectCreditStatus.none,
                          creditMatchScore: null,
                        ),
                      ),
                      icon: const Icon(Icons.link_off_rounded),
                      label: const Text('Limpar aproveitamento'),
                    ),
                  ],
                ),
              ),
            ],
            if (suggestions.isNotEmpty) ...[
              const SizedBox(height: 16),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Possiveis aproveitamentos',
                  helperText:
                      'Sugestoes encontradas em outros perfis com base no nome e na ementa da disciplina.',
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: suggestions
                      .map(
                        (suggestion) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  suggestion.existingSubjectName,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    Chip(
                                      label: Text(
                                        suggestion.existingProfileName,
                                      ),
                                    ),
                                    Chip(
                                      label: Text(
                                        suggestion.existingStatus.label,
                                      ),
                                    ),
                                    Chip(
                                      label: Text(
                                        'Nome ${_formatPercent(suggestion.nameSimilarity)}',
                                      ),
                                    ),
                                    if (suggestion.syllabusSimilarity > 0)
                                      Chip(
                                        label: Text(
                                          'Ementa ${_formatPercent(suggestion.syllabusSimilarity)}',
                                        ),
                                      ),
                                    Chip(
                                      label: Text(
                                        'Carga ${_formatPercent(suggestion.workloadSimilarity)}',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  suggestion.isCompletedEquivalent
                                      ? 'Essa disciplina ja aparece como concluida em outro perfil e pode ser uma boa candidata a aproveitamento.'
                                      : 'Foi encontrada uma disciplina muito parecida em outro perfil. Se ela ja foi cursada, vale avaliar o aproveitamento.',
                                ),
                                const SizedBox(height: 12),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: FilledButton.tonalIcon(
                                    onPressed:
                                        subject.creditSourceSubjectId ==
                                                    suggestion.existingSubjectId &&
                                                subject.creditSourceProfileId ==
                                                    suggestion
                                                        .existingProfileId &&
                                                subject.creditStatus ==
                                                    CourseSubjectCreditStatus
                                                        .requested
                                            ? null
                                            : () => onChanged(
                                                  subject.copyWith(
                                                    creditSourceSubjectId:
                                                        suggestion
                                                            .existingSubjectId,
                                                    creditSourceProfileId:
                                                        suggestion
                                                            .existingProfileId,
                                                    creditStatus:
                                                        CourseSubjectCreditStatus
                                                            .requested,
                                                    creditMatchScore:
                                                        suggestion.matchScore,
                                                  ),
                                                ),
                                    icon: const Icon(Icons.assignment_turned_in),
                                    label: Text(
                                      subject.creditSourceSubjectId ==
                                                  suggestion.existingSubjectId &&
                                              subject.creditSourceProfileId ==
                                                  suggestion.existingProfileId &&
                                              subject.creditStatus ==
                                                  CourseSubjectCreditStatus
                                                      .requested
                                          ? 'Selecionado'
                                          : 'Marcar aproveitamento',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
            const SizedBox(height: 16),
            TextFormField(
              initialValue: subject.notes ?? '',
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Observacoes (opcional)',
              ),
              onChanged: (value) => onChanged(
                subject.copyWith(
                  notes: value.trim().isEmpty ? null : value.trim(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPercent(double value) {
    return '${(value * 100).round()}%';
  }
}

enum _CurriculumImportTargetMode { newProfile, updateExisting }
