// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/backup/backup_service.dart';
import '../../../../core/feedback/error_report_providers.dart';
import '../../../../core/network/api_settings.dart';
import '../../../../core/sync/remote_sync_service.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../../core/theme/app_color_profile.dart';
import '../../../../core/theme/color_profile_controller.dart';
import '../../../../core/theme/theme_mode_controller.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
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
  bool _syncingNow = false;
  bool _discardingSyncQueue = false;
  bool _testingApiConnection = false;
  bool _apiSettingsDirty = false;
  late final TextEditingController _colorProfileNameController;
  late final TextEditingController _apiBaseUrlController;
  bool _colorProfileDirty = false;

  @override
  void initState() {
    super.initState();
    final initialProfile = ref.read(colorProfileControllerProvider);
    final initialApiSettings = ref.read(apiSettingsControllerProvider);
    _colorProfileNameController = TextEditingController(
      text: initialProfile.name,
    );
    _apiBaseUrlController = TextEditingController(
      text: initialApiSettings.normalizedBaseUrl,
    );
  }

  @override
  void dispose() {
    _colorProfileNameController.dispose();
    _apiBaseUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themePreference = ref.watch(themeModeControllerProvider);
    final colorProfile = ref.watch(colorProfileControllerProvider);
    final restorePointAvailable = ref.watch(
      backupRestorePointAvailableProvider,
    );
    final restorePointCreatedAt = ref.watch(
      backupRestorePointCreatedAtProvider,
    );
    final syncOverview = ref.watch(syncQueueOverviewProvider);
    final queuedReports = ref.watch(queuedErrorReportCountProvider);
    final syncDeviceId = ref.watch(syncDeviceIdProvider);
    final syncInfo = ref.watch(syncQueueServiceProvider);
    final authState = ref.watch(authControllerProvider);
    final apiSettings = ref.watch(apiSettingsControllerProvider);
    final currentSyncOverview = syncOverview.valueOrNull;

    if (!_colorProfileDirty &&
        _colorProfileNameController.text != colorProfile.name) {
      _colorProfileNameController.text = colorProfile.name;
    }
    if (!_apiSettingsDirty &&
        _apiBaseUrlController.text != apiSettings.normalizedBaseUrl) {
      _apiBaseUrlController.text = apiSettings.normalizedBaseUrl;
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
                  'Seguranca da conta',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  authState.account == null
                      ? 'Nenhuma conta local carregada.'
                      : 'Sessao atual: ${authState.account!.displayName} (${authState.account!.email})',
                ),
                const SizedBox(height: 6),
                Text(
                  authState.account?.isGoogleLinked == true
                      ? 'Google vinculado a esta conta.'
                      : 'Google ainda nao vinculado a esta conta.',
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _signOut,
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Sair e bloquear app'),
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
                  'Servidor e sincronizacao',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text(
                  'O CampusFlow usa o endpoint configurado no build ou salvo neste dispositivo. Se o servidor cair durante a apresentacao, limpe o endpoint para usar o modo local/offline.',
                ),
                const SizedBox(height: 16),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          apiSettings.hasServer
                              ? Icons.cloud_done_rounded
                              : Icons.cloud_off_rounded,
                          color: apiSettings.hasServer
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiSettings.hasServer
                                    ? 'Servidor ativo'
                                    : 'Servidor nao configurado',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                apiSettings.hasServer
                                    ? apiSettings.normalizedBaseUrl
                                    : 'Modo local/offline ativo neste dispositivo.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Wrap(
                      spacing: 18,
                      runSpacing: 10,
                      children: [
                        _StatusPill(
                          icon: Icons.cloud_queue_rounded,
                          label: 'Conexao',
                          value: _connectionStatusLabel(apiSettings),
                        ),
                        _StatusPill(
                          icon: Icons.sync_rounded,
                          label: 'Sync',
                          value: _syncStatusLabel(
                            apiSettings,
                            currentSyncOverview,
                          ),
                        ),
                        _StatusPill(
                          icon: Icons.bug_report_rounded,
                          label: 'Reports',
                          value:
                              '${queuedReports.valueOrNull ?? 0} aguardando reenvio',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _apiBaseUrlController,
                  decoration: const InputDecoration(
                    labelText: 'Endpoint da API',
                    helperText:
                        'Exemplo local: http://localhost:3333. Deixe vazio apenas para modo offline/local.',
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (_) {
                    setState(() => _apiSettingsDirty = true);
                  },
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: _apiSettingsDirty ? _saveApiEndpoint : null,
                      icon: const Icon(Icons.save_rounded),
                      label: const Text('Salvar endpoint'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _testingApiConnection || !apiSettings.hasServer
                          ? null
                          : _testApiConnection,
                      icon: _testingApiConnection
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.wifi_tethering_rounded),
                      label: const Text('Testar conexao'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _resetApiEndpoint,
                      icon: const Icon(Icons.restore_rounded),
                      label: const Text('Restaurar padrao do build'),
                    ),
                    OutlinedButton.icon(
                      onPressed: apiSettings.hasServer
                          ? _clearApiEndpoint
                          : null,
                      icon: const Icon(Icons.cloud_off_rounded),
                      label: const Text('Usar modo local/offline'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _syncingNow || !apiSettings.hasServer
                          ? null
                          : _syncNow,
                      icon: _syncingNow
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.sync_rounded),
                      label: const Text('Sincronizar agora'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _discardingSyncQueue
                          ? null
                          : _discardOldSyncQueue,
                      icon: _discardingSyncQueue
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.cleaning_services_rounded),
                      label: const Text('Descartar fila antiga'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/feedback'),
                      icon: const Icon(Icons.bug_report_rounded),
                      label: const Text('Reportar erro ou feedback'),
                    ),
                  ],
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
                        onPressed: _processingBackup
                            ? null
                            : _restorePreviousState,
                        icon: const Icon(Icons.history_rounded),
                        label: const Text('Restaurar estado anterior'),
                      ),
                  ],
                ),
                if (restorePointAvailable.valueOrNull ?? false) ...[
                  const SizedBox(height: 16),
                  Card(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
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
                  'Sincronizacao com servidor',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(syncInfo.description),
                const SizedBox(height: 16),
                syncOverview.when(
                  data: (overview) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Device ID: ${syncDeviceId.valueOrNull ?? overview.deviceId}',
                      ),
                      const SizedBox(height: 8),
                      Text('Pendencias na fila: ${overview.pendingCount}'),
                      const SizedBox(height: 4),
                      Text(
                        'Falhas aguardando tratamento: ${overview.failedCount}',
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ultima sincronizacao registrada: '
                        '${AppFormatters.formatDateTime(overview.lastSyncedAt)}',
                      ),
                    ],
                  ),
                  loading: () =>
                      const Text('Carregando status da fila local...'),
                  error: (error, _) =>
                      Text('Nao foi possivel ler a fila local: $error'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Todas as entidades carregam metadados de sincronizacao, incluindo id local, remoteId, createdAt, updatedAt, syncStatus e isDeleted. As alteracoes entram em uma fila local e sao reenviadas se uma tentativa falhar. Se a fila vier de dados muito antigos, descarte a fila antiga para comecar a sincronizar apenas alteracoes novas.',
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
    final confirmed =
        await showDialog<bool>(
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
          imported ? 'Backup importado com sucesso.' : 'Importacao cancelada.',
        ),
      ),
    );
  }

  Future<void> _restorePreviousState() async {
    setState(() => _processingBackup = true);

    bool restored = false;
    try {
      restored = await ref
          .read(backupServiceProvider)
          .restoreTemporaryRestorePoint();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Falha ao restaurar o estado anterior: $error'),
          ),
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

    await ref
        .read(colorProfileControllerProvider.notifier)
        .updateProfile(updatedProfile);
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
    return ref
        .read(colorProfileControllerProvider.notifier)
        .updateProfile(
          profile.copyWith(
            name: _colorProfileNameController.text.trim().isEmpty
                ? profile.name
                : _colorProfileNameController.text.trim(),
          ),
        );
  }

  Future<void> _signOut() async {
    await ref.read(authControllerProvider.notifier).signOut();
  }

  Future<void> _saveApiEndpoint() async {
    final normalized = ApiSettings.normalizeBaseUrl(_apiBaseUrlController.text);
    await ref
        .read(apiSettingsControllerProvider.notifier)
        .update(ApiSettings(baseUrl: normalized));
    await ref.read(authControllerProvider.notifier).refresh();

    if (!mounted) {
      return;
    }

    setState(() => _apiSettingsDirty = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          normalized.isEmpty
              ? 'Modo local/offline ativado neste dispositivo.'
              : 'Endpoint salvo: $normalized',
        ),
      ),
    );
  }

  Future<void> _resetApiEndpoint() async {
    await ref
        .read(apiSettingsControllerProvider.notifier)
        .resetToBuildDefault();
    final settings = ref.read(apiSettingsControllerProvider);
    await ref.read(authControllerProvider.notifier).refresh();

    if (!mounted) {
      return;
    }

    _apiBaseUrlController.text = settings.normalizedBaseUrl;
    setState(() => _apiSettingsDirty = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Endpoint restaurado: ${settings.normalizedBaseUrl}'),
      ),
    );
  }

  Future<void> _clearApiEndpoint() async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Usar modo local/offline?'),
            content: const Text(
              'Isso nao apaga dados. O login e a sincronizacao remotos deixam de ser usados neste dispositivo ate voce salvar um endpoint novamente.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Usar offline'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    _apiBaseUrlController.clear();
    await _saveApiEndpoint();
  }

  Future<void> _testApiConnection() async {
    setState(() => _testingApiConnection = true);
    Object? failure;
    Map<String, dynamic>? response;
    try {
      response = await ref
          .read(apiClientProvider)
          .get('/health', authenticated: false);
      await ref.read(errorReportServiceProvider).flushQueuedReports();
      ref.invalidate(queuedErrorReportCountProvider);
    } catch (error) {
      failure = error;
    } finally {
      if (mounted) {
        setState(() => _testingApiConnection = false);
      }
    }

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          failure != null
              ? 'Nao foi possivel conectar: $failure'
              : 'Servidor respondeu: ${response?['status'] ?? 'ok'}.',
        ),
      ),
    );
  }

  Future<void> _syncNow() async {
    setState(() => _syncingNow = true);
    RemoteSyncRunResult? result;
    Object? failure;
    try {
      result = await ref.read(remoteSyncServiceProvider).syncNow();
      ref.invalidate(syncQueueOverviewProvider);
    } catch (error) {
      failure = error;
    } finally {
      if (mounted) {
        setState(() => _syncingNow = false);
      }
    }

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          failure != null
              ? 'Falha ao sincronizar: $failure'
              : 'Sync concluida: ${result!.pushed} enviados, '
                    '${result.failed} falhas, '
                    '${result.conflicts} conflitos, ${result.pulled} lidos.',
        ),
      ),
    );
  }

  Future<void> _discardOldSyncQueue() async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Descartar fila antiga?'),
            content: const Text(
              'Isso nao apaga seus perfis, disciplinas, aulas, horas ou anexos. Apenas remove tentativas antigas de sincronizacao local. Depois disso, somente novas alteracoes entrarao na fila para o servidor.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Descartar fila'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    setState(() => _discardingSyncQueue = true);
    Object? failure;
    var deleted = 0;
    try {
      deleted = await ref.read(syncQueueServiceProvider).discardLocalQueue();
      ref.invalidate(syncQueueOverviewProvider);
    } catch (error) {
      failure = error;
    } finally {
      if (mounted) {
        setState(() => _discardingSyncQueue = false);
      }
    }

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          failure != null
              ? 'Falha ao descartar fila antiga: $failure'
              : 'Fila antiga descartada: $deleted registros removidos.',
        ),
      ),
    );
  }
}

String _connectionStatusLabel(ApiSettings settings) {
  if (!settings.hasServer) {
    return 'offline';
  }
  return settings.isLocalServer ? 'local configurado' : 'remoto configurado';
}

String _syncStatusLabel(ApiSettings settings, SyncQueueOverview? overview) {
  if (!settings.hasServer) {
    return 'offline';
  }
  if (overview == null) {
    return 'carregando';
  }
  if (overview.failedCount > 0) {
    return 'falhou';
  }
  if (overview.pendingCount > 0) {
    return 'pendente';
  }
  return 'sincronizado';
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Text('$label: ', style: Theme.of(context).textTheme.labelLarge),
        Text(value),
      ],
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
