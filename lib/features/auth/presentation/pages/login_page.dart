// Signature: dev.tswicolly03

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/google_auth_identity.dart';
import '../../../../shared/widgets/form_submission_state.dart';
import '../providers/auth_providers.dart';
import '../providers/login_form_controller.dart';
import '../widgets/google_sign_in_button.dart';

enum _LoginMode { signIn, register }

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _displayNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  StreamSubscription<GoogleAuthIdentity>? _googleAuthSubscription;
  _LoginMode? _mode;
  bool _modeTouched = false;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    final googleAuthService = ref.read(googleAuthServiceProvider);
    _googleAuthSubscription = googleAuthService.authenticationEvents.listen(
      _signInWithGoogleIdentity,
    );
    if (googleAuthService.capability.isSupported &&
        googleAuthService.capability.isConfigured) {
      unawaited(googleAuthService.initialize());
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _googleAuthSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authControllerProvider);
    final submission = ref.watch(loginFormControllerProvider);
    final effectiveMode = _resolveMode(authState.hasAccount);

    ref.listen<FormSubmissionState>(loginFormControllerProvider, (
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

    if (_emailController.text.trim().isEmpty && authState.account != null) {
      _emailController.text = authState.account!.email;
    }

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.primaryContainer.withValues(alpha: 0.32),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 880;

                    return Flex(
                      direction: isWide ? Axis.horizontal : Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _BrandPanel(showCompactLayout: !isWide),
                        ),
                        SizedBox(
                          width: isWide ? 24 : 0,
                          height: isWide ? 0 : 24,
                        ),
                        Expanded(
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(28),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        effectiveMode == _LoginMode.signIn
                                            ? 'Entrar no CampusFlow'
                                            : 'Criar conta segura',
                                        style: theme.textTheme.headlineSmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        effectiveMode == _LoginMode.signIn
                                            ? 'Entre com email e senha ou use uma conta Google vinculada ao servidor.'
                                            : 'Sua conta sera criada no servidor do CampusFlow para sincronizar seus dados entre dispositivos.',
                                      ),
                                      const SizedBox(height: 24),
                                      SegmentedButton<_LoginMode>(
                                        segments: const [
                                          ButtonSegment(
                                            value: _LoginMode.signIn,
                                            label: Text('Entrar'),
                                          ),
                                          ButtonSegment(
                                            value: _LoginMode.register,
                                            label: Text('Criar conta'),
                                          ),
                                        ],
                                        selected: {effectiveMode},
                                        onSelectionChanged: (selection) {
                                          setState(() {
                                            _modeTouched = true;
                                            _mode = selection.first;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      if (effectiveMode ==
                                          _LoginMode.register) ...[
                                        TextFormField(
                                          controller: _displayNameController,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          decoration: const InputDecoration(
                                            labelText: 'Seu nome',
                                            prefixIcon: Icon(
                                              Icons.person_rounded,
                                            ),
                                          ),
                                          validator: (value) {
                                            if ((value ?? '').trim().isEmpty) {
                                              return 'Informe seu nome.';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                      ],
                                      TextFormField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                          prefixIcon: Icon(
                                            Icons.alternate_email_rounded,
                                          ),
                                        ),
                                        validator: (value) {
                                          final trimmed = (value ?? '').trim();
                                          if (trimmed.isEmpty ||
                                              !trimmed.contains('@')) {
                                            return 'Informe um email valido.';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _passwordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          labelText: 'Senha',
                                          prefixIcon: Icon(Icons.lock_rounded),
                                        ),
                                        validator: (value) {
                                          final trimmed = (value ?? '').trim();
                                          if (trimmed.length < 8) {
                                            return 'Use pelo menos 8 caracteres.';
                                          }
                                          return null;
                                        },
                                      ),
                                      if (effectiveMode ==
                                          _LoginMode.register) ...[
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          controller:
                                              _confirmPasswordController,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            labelText: 'Confirmar senha',
                                            prefixIcon: Icon(
                                              Icons.verified_user_rounded,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value !=
                                                _passwordController.text) {
                                              return 'As senhas precisam ser iguais.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                      const SizedBox(height: 20),
                                      if (authState.account?.hasPassword ==
                                              false &&
                                          effectiveMode == _LoginMode.signIn)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16,
                                          ),
                                          child: Card(
                                            color: theme
                                                .colorScheme
                                                .secondaryContainer,
                                            elevation: 0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                'Esta conta foi criada sem senha local. Entre com Google ou use "Esqueceu sua senha?" para definir uma senha agora.',
                                                style: theme
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: theme
                                                          .colorScheme
                                                          .onSecondaryContainer,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: FilledButton.icon(
                                          onPressed: submission.isLoading
                                              ? null
                                              : () => _submit(effectiveMode),
                                          icon: submission.isLoading
                                              ? const SizedBox(
                                                  height: 18,
                                                  width: 18,
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                      ),
                                                )
                                              : Icon(
                                                  effectiveMode ==
                                                          _LoginMode.signIn
                                                      ? Icons.login_rounded
                                                      : Icons.shield_rounded,
                                                ),
                                          label: Text(
                                            effectiveMode == _LoginMode.signIn
                                                ? 'Entrar'
                                                : 'Criar conta e entrar',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      GoogleSignInButton(
                                        enabled:
                                            authState.googleSupported &&
                                            authState.googleConfigured,
                                        isLoading: submission.isLoading,
                                        onPressed: _signInWithGoogle,
                                      ),
                                      if (authState.googleAvailabilityMessage !=
                                          null) ...[
                                        const SizedBox(height: 8),
                                        Text(
                                          authState.googleAvailabilityMessage!,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color: theme
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: submission.isLoading
                                                ? null
                                                : () => context.go(
                                                    '/forgot-password'
                                                    '?email=${Uri.encodeComponent(_emailController.text.trim())}',
                                                  ),
                                            child: const Text(
                                              'Esqueceu sua senha?',
                                            ),
                                          ),
                                          const Spacer(),
                                          if (effectiveMode ==
                                              _LoginMode.signIn)
                                            TextButton(
                                              onPressed: submission.isLoading
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        _modeTouched = true;
                                                        _mode =
                                                            _LoginMode.register;
                                                      });
                                                    },
                                              child: const Text(
                                                'Primeiro acesso',
                                              ),
                                            ),
                                        ],
                                      ),
                                      if (authState.errorMessage != null) ...[
                                        const SizedBox(height: 8),
                                        Text(
                                          authState.errorMessage!,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color: theme.colorScheme.error,
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _LoginMode _resolveMode(bool hasAccount) {
    _mode ??= hasAccount ? _LoginMode.signIn : _LoginMode.register;
    if (!_modeTouched) {
      _mode = hasAccount ? _LoginMode.signIn : _LoginMode.register;
    }
    return _mode!;
  }

  Future<void> _submit(_LoginMode mode) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (mode == _LoginMode.signIn) {
      await ref
          .read(loginFormControllerProvider.notifier)
          .signInWithPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      return;
    }

    final result = await ref
        .read(loginFormControllerProvider.notifier)
        .register(
          displayName: _displayNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
    if (!mounted || result?.recoveryCode == null) {
      return;
    }

    await _showRecoveryCodeDialog(
      title: 'Guarde seu codigo de recuperacao',
      description:
          'Se voce esquecer a senha, esse codigo permite definir uma nova localmente sem depender de servidor.',
      recoveryCode: result!.recoveryCode!,
    );
  }

  Future<void> _signInWithGoogle() async {
    final result = await ref
        .read(loginFormControllerProvider.notifier)
        .signInWithGoogle();
    if (!mounted || result?.recoveryCode == null) {
      return;
    }

    await _showRecoveryCodeDialog(
      title: 'Conta criada com Google',
      description:
          'Sua conta Google foi vinculada. Guarde este codigo para recuperar ou definir uma senha local depois.',
      recoveryCode: result!.recoveryCode!,
    );
  }

  Future<void> _signInWithGoogleIdentity(GoogleAuthIdentity identity) async {
    final result = await ref
        .read(loginFormControllerProvider.notifier)
        .signInWithGoogleIdentity(identity);
    if (!mounted || result?.recoveryCode == null) {
      return;
    }

    await _showRecoveryCodeDialog(
      title: 'Conta criada com Google',
      description:
          'Sua conta Google foi vinculada. Guarde este codigo para recuperar ou definir uma senha local depois.',
      recoveryCode: result!.recoveryCode!,
    );
  }

  Future<void> _showRecoveryCodeDialog({
    required String title,
    required String description,
    required String recoveryCode,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 16),
            SelectableText(
              recoveryCode,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }
}

class _BrandPanel extends StatelessWidget {
  const _BrandPanel({required this.showCompactLayout});

  final bool showCompactLayout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: showCompactLayout
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.school_rounded,
              size: 36,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'CampusFlow',
            style: theme.textTheme.displaySmall?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Seu painel academico agora tambem pode ficar protegido por senha local segura, com recuperacao e opcao de vinculo com Google.',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.92),
            ),
          ),
          const SizedBox(height: 24),
          _FeatureBullet(
            text: 'Senha guardada com hash forte e cofre seguro do dispositivo',
            color: theme.colorScheme.onPrimary,
          ),
          _FeatureBullet(
            text: 'Codigo de recuperacao local para continuar offline-first',
            color: theme.colorScheme.onPrimary,
          ),
          _FeatureBullet(
            text: 'Conta Google como metodo complementar quando disponivel',
            color: theme.colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }
}

class _FeatureBullet extends StatelessWidget {
  const _FeatureBullet({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_rounded, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: color.withValues(alpha: 0.92),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
