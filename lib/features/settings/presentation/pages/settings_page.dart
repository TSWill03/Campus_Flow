import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/backup/backup_service.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../../core/theme/app_color_profile.dart';
import '../../../../core/theme/color_profile_controller.dart';
import '../../../../core/theme/theme_mode_controller.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../shared/enums/theme_preference.dart';
import '../../../../shared/widgets/section_header.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  static const _palette = <int>[
    0xFF0F766E,
    0xFF1D4ED8,
    0xFFB45309,
    0xFFBE185D,
    0xFF6D28D9,
    0xFF15803D,
  ];

  bool _processingBackup = false;
  late final TextEditingController _colorProfileNameController;
  bool _colorProfileDirty = false;

  @override
  void initState() {
    super.initState();
    final initialProfile = ref.read(colorProfileControllerProvider);
    _colorProfileNameController =
        TextEditingController(text: initialProfile.name);
  }

  @override
  void dispose() {
    _colorProfileNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themePreference = ref.watch(themeModeControllerProvider);
    final colorProfile = ref.watch(colorProfileControllerProvider);
    final restorePointAvailable = ref.watch(backupRestorePointAvailableProvider);
    final restorePointCreatedAt = ref.watch(backupRestorePointCreatedAtProvider);
    final syncOverview = ref.watch(syncQueueOverviewProvider);
    final syncDeviceId = ref.watch(syncDeviceIdProvider);
    final syncInfo = ref.watch(syncQueueServiceProvider);

    if (!_colorProfileDirty &&
        _colorProfileNameController.text != colorProfile.name) {
      _colorProfileNameController.text = colorProfile.name;
    }

    return ListView(
      children: [
        const SectionHeader(
          title: 'Ajustes',
          subtitle:
              'Personalize o tema, gerencie backups locais e confira como a arquitetura foi preparada para evolucao futura.',
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tema do aplicativo',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                SegmentedButton<ThemePreference>(
                  segments: ThemePreference.values
                      .map(
                        (preference) => ButtonSegment(
                          value: preference,
                          label: Text(preference.label),
                        ),
                      )
                      .toList(),
                  selected: {themePreference},
                  onSelectionChanged: (selection) {
                    ref
                        .read(themeModeControllerProvider.notifier)
                        .updatePreference(selection.first);
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perfil de cores',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Crie um esquema visual mais pessoal escolhendo nome, cor principal e cor de destaque.',
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _colorProfileNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do perfil de cores',
                  ),
                  onChanged: (_) {
                    setState(() => _colorProfileDirty = true);
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Cor principal',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _palette
                      .map(
                        (value) => _ColorChip(
                          color: Color(value),
                          selected: colorProfile.seedColorValue == value,
                          onTap: () => _updateColorProfile(
                            colorProfile.copyWith(seedColorValue: value),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  'Cor de destaque',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _palette
                      .map(
                        (value) => _ColorChip(
                          color: Color(value),
                          selected: colorProfile.accentColorValue == value,
                          onTap: () => _updateColorProfile(
                            colorProfile.copyWith(accentColorValue: value),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorProfile.seedColor,
                          foregroundColor: Colors.white,
                          child: const Icon(Icons.palette_rounded),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _colorProfileNameController.text.trim().isEmpty
                                ? colorProfile.name
                                : _colorProfileNameController.text.trim(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        FilledButton(
                          onPressed: () => _saveColorProfile(colorProfile),
                          child: const Text('Salvar'),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: _resetColorProfile,
                          child: const Text('Resetar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Backup local em JSON',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Exporte todos os dados para um arquivo JSON e importe manualmente em outro dispositivo quando necessario.',
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: _processingBackup ? null : _exportBackup,
                      icon: _processingBackup
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.upload_file_rounded),
                      label: const Text('Exportar backup'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _processingBackup ? null : _importBackup,
                      icon: const Icon(Icons.download_rounded),
                      label: const Text('Importar backup'),
                    ),
                    if (restorePointAvailable.valueOrNull ?? false)
                      OutlinedButton.icon(
                        onPressed: _processingBackup ? null : _restorePreviousState,
                        icon: const Icon(Icons.history_rounded),
                        label: const Text('Restaurar estado anterior'),
                      ),
                  ],
                ),
                if (restorePointAvailable.valueOrNull ?? false) ...[
                  const SizedBox(height: 16),
                  Card(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Ultimo restore point salvo em '
                        '${AppFormatters.formatDateTime(restorePointCreatedAt.valueOrNull)}.',
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preparacao para sincronizacao futura',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(syncInfo.description),
                const SizedBox(height: 16),
                syncOverview.when(
                  data: (overview) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Device ID: ${syncDeviceId.valueOrNull ?? overview.deviceId}'),
                      const SizedBox(height: 8),
                      Text('Pendencias na fila: ${overview.pendingCount}'),
                      const SizedBox(height: 4),
                      Text('Falhas aguardando tratamento: ${overview.failedCount}'),
                      const SizedBox(height: 4),
                      Text(
                        'Ultima sincronizacao registrada: '
                        '${AppFormatters.formatDateTime(overview.lastSyncedAt)}',
                      ),
                    ],
                  ),
                  loading: () => const Text('Carregando status da fila local...'),
                  error: (error, _) => Text('Nao foi possivel ler a fila local: $error'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Todas as entidades carregam metadados de sincronizacao, incluindo id local, remoteId, createdAt, updatedAt, syncStatus e isDeleted. As alteracoes tambem entram em uma fila local com payload e entityVersion.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _exportBackup() async {
    setState(() => _processingBackup = true);

    String? path;
    try {
      path = await ref.read(backupServiceProvider).exportBackup();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao exportar backup: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _processingBackup = false);
      }
    }

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          path == null
              ? 'Exportacao cancelada.'
              : 'Backup exportado com sucesso.',
        ),
      ),
    );
  }

  Future<void> _importBackup() async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Importar backup?'),
            content: const Text(
              'Os dados atuais serao substituidos pelo conteudo do arquivo selecionado.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Importar'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    setState(() => _processingBackup = true);

    bool imported = false;
    try {
      imported = await ref.read(backupServiceProvider).importBackup();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao importar backup: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _processingBackup = false);
      }
    }

    if (!mounted) {
      return;
    }

    ref.invalidate(backupRestorePointAvailableProvider);
    ref.invalidate(backupRestorePointCreatedAtProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          imported
              ? 'Backup importado com sucesso.'
              : 'Importacao cancelada.',
        ),
      ),
    );
  }

  Future<void> _restorePreviousState() async {
    setState(() => _processingBackup = true);

    bool restored = false;
    try {
      restored = await ref.read(backupServiceProvider).restoreTemporaryRestorePoint();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao restaurar o estado anterior: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _processingBackup = false);
      }
    }

    if (!mounted) {
      return;
    }

    ref.invalidate(backupRestorePointAvailableProvider);
    ref.invalidate(backupRestorePointCreatedAtProvider);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          restored
              ? 'Estado anterior restaurado com sucesso.'
              : 'Nenhum restore point disponivel.',
        ),
      ),
    );
  }

  Future<void> _saveColorProfile(AppColorProfile currentProfile) async {
    final updatedProfile = currentProfile.copyWith(
      name: _colorProfileNameController.text.trim().isEmpty
          ? currentProfile.name
          : _colorProfileNameController.text.trim(),
    );

    await ref.read(colorProfileControllerProvider.notifier).updateProfile(
          updatedProfile,
        );
    if (!mounted) {
      return;
    }

    setState(() => _colorProfileDirty = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil de cores atualizado.')),
    );
  }

  Future<void> _resetColorProfile() async {
    await ref.read(colorProfileControllerProvider.notifier).reset();
    final profile = ref.read(colorProfileControllerProvider);
    _colorProfileNameController.text = profile.name;
    setState(() => _colorProfileDirty = false);
  }

  Future<void> _updateColorProfile(AppColorProfile profile) {
    return ref.read(colorProfileControllerProvider.notifier).updateProfile(
          profile.copyWith(
            name: _colorProfileNameController.text.trim().isEmpty
                ? profile.name
                : _colorProfileNameController.text.trim(),
          ),
        );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.onSurface
                : Colors.transparent,
            width: 3,
          ),
        ),
      ),
    );
  }
}
