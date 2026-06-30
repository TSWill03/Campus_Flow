// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../core/feedback/error_report_providers.dart';
import '../../../../core/feedback/error_report_service.dart';
import '../../../../core/network/api_settings.dart';
import '../../../../core/sync/sync_queue_service.dart';
import '../../../../shared/widgets/section_header.dart';

class FeedbackReportPage extends ConsumerStatefulWidget {
  const FeedbackReportPage({super.key});

  @override
  ConsumerState<FeedbackReportPage> createState() => _FeedbackReportPageState();
}

class _FeedbackReportPageState extends ConsumerState<FeedbackReportPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _descriptionController;
  ErrorReportType _type = ErrorReportType.feedback;
  ErrorReportSeverity _severity = ErrorReportSeverity.medium;
  bool _sending = false;
  String? _successReportId;
  String? _failureMessage;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apiSettings = ref.watch(apiSettingsControllerProvider);
    final syncOverview = ref.watch(syncQueueOverviewProvider).valueOrNull;
    final queuedReports = ref.watch(queuedErrorReportCountProvider).valueOrNull;

    return ListView(
      children: [
        SectionHeader(
          title: 'Reportar erro ou enviar feedback',
          subtitle:
              'Serão enviados apenas dados técnicos necessários para análise. Dados acadêmicos e arquivos pessoais não serão enviados.',
          action: OutlinedButton.icon(
            onPressed: () => context.go('/settings'),
            icon: const Icon(Icons.arrow_back_rounded),
            label: const Text('Voltar'),
          ),
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<ErrorReportType>(
                    initialValue: _type,
                    decoration: const InputDecoration(
                      labelText: 'Categoria',
                      prefixIcon: Icon(Icons.category_rounded),
                    ),
                    items: ErrorReportType.values
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(type.label),
                          ),
                        )
                        .toList(),
                    onChanged: _sending
                        ? null
                        : (value) => setState(() => _type = value ?? _type),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<ErrorReportSeverity>(
                    initialValue: _severity,
                    decoration: const InputDecoration(
                      labelText: 'Severidade',
                      prefixIcon: Icon(Icons.priority_high_rounded),
                    ),
                    items: ErrorReportSeverity.values
                        .map(
                          (severity) => DropdownMenuItem(
                            value: severity,
                            child: Text(severity.label),
                          ),
                        )
                        .toList(),
                    onChanged: _sending
                        ? null
                        : (value) =>
                              setState(() => _severity = value ?? _severity),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    minLines: 5,
                    maxLines: 8,
                    maxLength: 4000,
                    decoration: const InputDecoration(
                      labelText: 'Descreva o que aconteceu',
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.feedback_rounded),
                    ),
                    validator: (value) {
                      if ((value ?? '').trim().length < 10) {
                        return 'Descreva o problema com pelo menos 10 caracteres.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton.icon(
                        onPressed: _sending ? null : _sendFeedback,
                        icon: _sending
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.send_rounded),
                        label: const Text('Enviar'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _copyTechnicalInfo,
                        icon: const Icon(Icons.copy_rounded),
                        label: const Text('Copiar dados técnicos'),
                      ),
                    ],
                  ),
                  if (_successReportId != null) ...[
                    const SizedBox(height: 16),
                    _ResultCard(
                      icon: Icons.check_circle_rounded,
                      message:
                          'Relatório enviado com sucesso. Número: $_successReportId',
                    ),
                  ],
                  if (_failureMessage != null) ...[
                    const SizedBox(height: 16),
                    _ResultCard(
                      icon: Icons.info_rounded,
                      message: _failureMessage!,
                      isError: true,
                    ),
                  ],
                ],
              ),
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
                  'Dados técnicos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                _TechnicalRow(
                  label: 'Endpoint ativo',
                  value: apiSettings.hasServer
                      ? apiSettings.normalizedBaseUrl
                      : 'Modo local/offline',
                ),
                _TechnicalRow(
                  label: 'Versao do app',
                  value:
                      '${ErrorReportService.appVersion}+${ErrorReportService.buildNumber}',
                ),
                _TechnicalRow(
                  label: 'Fila de sync',
                  value: syncOverview == null
                      ? 'Carregando'
                      : '${syncOverview.pendingCount} pendentes, ${syncOverview.failedCount} falhas',
                ),
                _TechnicalRow(
                  label: 'Reports locais',
                  value: '${queuedReports ?? 0} aguardando reenvio',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _sendFeedback() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _sending = true;
      _successReportId = null;
      _failureMessage = null;
    });

    try {
      await ref.read(errorReportServiceProvider).flushQueuedReports();
      final result = await ref
          .read(errorReportServiceProvider)
          .submitReport(
            ErrorReportPayload(
              type: _type,
              severity: _severity,
              message: 'Feedback manual do usuario',
              userDescription: _descriptionController.text.trim(),
              route: '/feedback',
              extra: {'source': 'manual_feedback_screen'},
            ),
            queueOnFailure: false,
          );
      if (!mounted) {
        return;
      }
      setState(() {
        _successReportId = result.reportId;
        _descriptionController.clear();
      });
      ref.invalidate(queuedErrorReportCountProvider);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _failureMessage = error is AppException
            ? error.message
            : 'Não foi possível enviar agora. Confira o endpoint da API e tente novamente.';
      });
    } finally {
      if (mounted) {
        setState(() => _sending = false);
      }
    }
  }

  Future<void> _copyTechnicalInfo() async {
    final info = await ref
        .read(errorReportServiceProvider)
        .technicalSummary(route: '/feedback');
    await Clipboard.setData(ClipboardData(text: info));
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Dados técnicos copiados.')));
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.icon,
    required this.message,
    this.isError = false,
  });

  final IconData icon;
  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final color = isError
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;
    return Card(
      color: color.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}

class _TechnicalRow extends StatelessWidget {
  const _TechnicalRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
