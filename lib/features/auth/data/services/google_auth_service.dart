// Signature: dev.tswicolly03

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/app_exception.dart';
import '../../domain/entities/google_auth_identity.dart';

class GoogleAuthCapability {
  const GoogleAuthCapability({
    required this.isSupported,
    required this.isConfigured,
    this.message,
  });

  final bool isSupported;
  final bool isConfigured;
  final String? message;
}

abstract class GoogleAuthService {
  GoogleAuthCapability get capability;

  Future<GoogleAuthIdentity> authenticate();

  Future<void> signOut();
}

class PlatformGoogleAuthService implements GoogleAuthService {
  PlatformGoogleAuthService({
    GoogleSignIn? googleSignIn,
    String? webClientId,
    String? serverClientId,
  })  : _googleSignIn = googleSignIn ?? GoogleSignIn.instance,
        _webClientId = webClientId ?? const String.fromEnvironment('GOOGLE_WEB_CLIENT_ID'),
        _serverClientId =
            serverClientId ?? const String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID');

  final GoogleSignIn _googleSignIn;
  final String _webClientId;
  final String _serverClientId;

  Future<void>? _initialization;

  @override
  GoogleAuthCapability get capability {
    if (kIsWeb) {
      if (_webClientId.trim().isEmpty) {
        return const GoogleAuthCapability(
          isSupported: true,
          isConfigured: false,
          message:
              'Defina GOOGLE_WEB_CLIENT_ID para ativar o login com Google na Web.',
        );
      }
      return const GoogleAuthCapability(
        isSupported: true,
        isConfigured: true,
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const GoogleAuthCapability(
          isSupported: true,
          isConfigured: true,
        );
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return const GoogleAuthCapability(
          isSupported: false,
          isConfigured: false,
          message:
              'O login com Google ainda nao esta disponivel no app desktop atual. Use email e senha neste dispositivo.',
        );
      case TargetPlatform.fuchsia:
        return const GoogleAuthCapability(
          isSupported: false,
          isConfigured: false,
          message: 'Login com Google indisponivel nesta plataforma.',
        );
    }
  }

  @override
  Future<GoogleAuthIdentity> authenticate() async {
    final currentCapability = capability;
    if (!currentCapability.isSupported) {
      throw AppException(
        currentCapability.message ??
            'Login com Google indisponivel nesta plataforma.',
      );
    }
    if (!currentCapability.isConfigured) {
      throw AppException(
        currentCapability.message ??
            'Configure o cliente OAuth do Google para continuar.',
      );
    }

    await _initializeIfNeeded();

    try {
      final account = await _googleSignIn.authenticate();
      return GoogleAuthIdentity(
        email: account.email.trim().toLowerCase(),
        displayName: (account.displayName ?? '').trim().isEmpty
            ? account.email.split('@').first
            : account.displayName!.trim(),
        photoUrl: account.photoUrl,
      );
    } catch (error) {
      if (error is AppException) {
        rethrow;
      }
      throw AppException('Nao foi possivel autenticar com Google: $error');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {
      // Melhor esforço: o logout local continua mesmo se a sessao Google falhar.
    }
  }

  Future<void> _initializeIfNeeded() {
    return _initialization ??= _googleSignIn.initialize(
      clientId: _webClientId.trim().isEmpty ? null : _webClientId.trim(),
      serverClientId: _serverClientId.trim().isEmpty
          ? null
          : _serverClientId.trim(),
    );
  }
}
