// Signature: dev.tswicolly03

import 'dart:async';

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

  bool get requiresOfficialButton => kIsWeb && isSupported && isConfigured;
}

abstract class GoogleAuthService {
  GoogleAuthCapability get capability;

  Stream<GoogleAuthIdentity> get authenticationEvents;

  Future<void> initialize();

  Future<GoogleAuthIdentity> authenticate();

  Future<void> signOut();
}

class PlatformGoogleAuthService implements GoogleAuthService {
  PlatformGoogleAuthService({
    GoogleSignIn? googleSignIn,
    String? webClientId,
    String? serverClientId,
  }) : _googleSignIn = googleSignIn ?? GoogleSignIn.instance,
       _webClientId =
           webClientId ?? const String.fromEnvironment('GOOGLE_WEB_CLIENT_ID'),
       _serverClientId =
           serverClientId ??
           const String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID'),
       _iosClientId = const String.fromEnvironment('GOOGLE_IOS_CLIENT_ID');

  final GoogleSignIn _googleSignIn;
  final String _webClientId;
  final String _serverClientId;
  final String _iosClientId;
  final StreamController<GoogleAuthIdentity> _authenticationController =
      StreamController<GoogleAuthIdentity>.broadcast();

  Future<void>? _initialization;
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authSubscription;

  @override
  Stream<GoogleAuthIdentity> get authenticationEvents =>
      _authenticationController.stream;

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
      return const GoogleAuthCapability(isSupported: true, isConfigured: true);
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        if (_serverClientId.trim().isEmpty) {
          return const GoogleAuthCapability(
            isSupported: true,
            isConfigured: false,
            message:
                'Defina GOOGLE_SERVER_CLIENT_ID com o Client ID Web do Google para ativar o login no Android.',
          );
        }
        return const GoogleAuthCapability(
          isSupported: true,
          isConfigured: true,
        );
      case TargetPlatform.iOS:
        if (_iosClientId.trim().isEmpty || _serverClientId.trim().isEmpty) {
          return const GoogleAuthCapability(
            isSupported: true,
            isConfigured: false,
            message:
                'Defina GOOGLE_IOS_CLIENT_ID e GOOGLE_SERVER_CLIENT_ID para ativar o login no iOS.',
          );
        }
        return const GoogleAuthCapability(
          isSupported: true,
          isConfigured: true,
        );
      case TargetPlatform.macOS:
        return const GoogleAuthCapability(
          isSupported: false,
          isConfigured: false,
          message:
              'O login com Google ainda nao esta configurado para macOS neste projeto.',
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
  Future<void> initialize() => _initializeIfNeeded();

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
    if (!_googleSignIn.supportsAuthenticate()) {
      throw const AppException(
        'Nesta plataforma, use o botao oficial do Google exibido na tela.',
      );
    }

    try {
      final account = await _googleSignIn.authenticate();
      return _identityFromAccount(account);
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
    return _initialization ??= () async {
      await _googleSignIn.initialize(
        clientId: _clientIdForCurrentPlatform(),
        serverClientId: kIsWeb ? null : _nullableTrimmed(_serverClientId),
      );
      _authSubscription ??= _googleSignIn.authenticationEvents.listen((event) {
        if (event is GoogleSignInAuthenticationEventSignIn) {
          _authenticationController.add(_identityFromAccount(event.user));
        }
      }, onError: _authenticationController.addError);
    }();
  }

  String? _clientIdForCurrentPlatform() {
    if (kIsWeb) {
      return _nullableTrimmed(_webClientId);
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return _nullableTrimmed(_iosClientId);
    }
    return null;
  }

  String? _nullableTrimmed(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  GoogleAuthIdentity _identityFromAccount(GoogleSignInAccount account) {
    return GoogleAuthIdentity(
      email: account.email.trim().toLowerCase(),
      displayName: (account.displayName ?? '').trim().isEmpty
          ? account.email.split('@').first
          : account.displayName!.trim(),
      photoUrl: account.photoUrl,
      idToken: account.authentication.idToken,
    );
  }
}
