// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/form_submission_state.dart';
import '../providers/auth_providers.dart';
import '../providers/password_recovery_controller.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key, this.prefilledEmail});

  final String? prefilledEmail;

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _recoveryCodeController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.prefilledEmail ?? '');
    _recoveryCodeController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _recoveryCodeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authControllerProvider);
    final submission = ref.watch(passwordRecoveryControllerProvider);

    ref.listen<FormSubmissionState>(passwordRecoveryControllerProvider, (
      previous,
      next,
    ) {
      if (!mounted ||
          next.message == null ||
          previous?.message == next.message) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(next.message!)));
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar acesso')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Redefinir senha local',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Como o app continua offline-first, a recuperacao usa um codigo local gerado no primeiro cadastro. Se voce vinculou Google, tambem pode validar a identidade por la e criar uma nova senha.',
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email da conta',
                                prefixIcon: Icon(Icons.alternate_email_rounded),
                              ),
                              validator: (value) {
                                final trimmed = (value ?? '').trim();
                                if (trimmed.isEmpty || !trimmed.contains('@')) {
                                  return 'Informe um email valido.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _recoveryCodeController,
                              decoration: const InputDecoration(
                                labelText: 'Codigo de recuperacao',
                                prefixIcon: Icon(Icons.key_rounded),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _newPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Nova senha',
                                prefixIcon: Icon(Icons.lock_reset_rounded),
                              ),
                              validator: (value) {
                                if ((value ?? '').trim().length < 8) {
                                  return 'Use pelo menos 8 caracteres.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Confirmar nova senha',
                                prefixIcon: Icon(Icons.verified_rounded),
                              ),
                              validator: (value) {
                                if (value != _newPasswordController.text) {
                                  return 'As senhas precisam ser iguais.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: submission.isLoading
                                    ? null
                                    : _requestResetToken,
                                icon: const Icon(Icons.mark_email_read_rounded),
                                label: const Text(
                                  'Solicitar codigo ao servidor',
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: submission.isLoading
                                    ? null
                                    : _resetWithRecoveryCode,
                                icon: submission.isLoading
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Icon(Icons.key_rounded),
                                label: const Text('Redefinir com codigo'),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed:
                                    submission.isLoading ||
                                        !authState.googleSupported ||
                                        !authState.googleConfigured
                                    ? null
                                    : _resetWithGoogle,
                                icon: const Icon(Icons.g_mobiledata_rounded),
                                label: const Text('Redefinir usando Google'),
                              ),
                            ),
                            if (authState.googleAvailabilityMessage !=
                                null) ...[
                              const SizedBox(height: 8),
                              Text(
                                authState.googleAvailabilityMessage!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => context.go('/login'),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Voltar para login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _resetWithRecoveryCode() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_recoveryCodeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Informe o codigo de recuperacao para continuar.'),
        ),
      );
      return;
    }

    await ref
        .read(passwordRecoveryControllerProvider.notifier)
        .resetWithRecoveryCode(
          email: _emailController.text.trim(),
          recoveryCode: _recoveryCodeController.text.trim(),
          newPassword: _newPasswordController.text,
        );
  }

  Future<void> _requestResetToken() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Informe um email valido.')));
      return;
    }

    final result = await ref
        .read(passwordRecoveryControllerProvider.notifier)
        .requestReset(email: email);
    if (!mounted || result?.recoveryCode == null) {
      return;
    }

    _recoveryCodeController.text = result!.recoveryCode!;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Token de desenvolvimento'),
        content: SelectableText(result.recoveryCode!),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Usar este token'),
          ),
        ],
      ),
    );
  }

  Future<void> _resetWithGoogle() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref
        .read(passwordRecoveryControllerProvider.notifier)
        .resetWithGoogle(
          email: _emailController.text.trim(),
          newPassword: _newPasswordController.text,
        );
  }
}
