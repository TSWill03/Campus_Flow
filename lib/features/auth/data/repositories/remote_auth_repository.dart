// Signature: dev.tswicolly03

import '../../../../core/error/app_exception.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_session_store.dart';
import '../../../../core/network/api_settings.dart';
import '../../domain/entities/auth_account.dart';
import '../../domain/entities/auth_action_result.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_snapshot.dart';
import '../../domain/entities/google_auth_identity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/google_auth_service.dart';

class RemoteAuthRepository implements AuthRepository {
  RemoteAuthRepository({
    required ApiClient apiClient,
    required ApiSessionStore sessionStore,
    required ApiSettings settings,
    required GoogleAuthService googleAuthService,
  }) : _apiClient = apiClient,
       _sessionStore = sessionStore,
       _settings = settings,
       _googleAuthService = googleAuthService;

  final ApiClient _apiClient;
  final ApiSessionStore _sessionStore;
  final ApiSettings _settings;
  final GoogleAuthService _googleAuthService;

  @override
  Future<AuthSnapshot> loadSnapshot() async {
    final capability = _googleAuthService.capability;
    if (!_settings.hasServer) {
      await _sessionStore.clear();
      return AuthSnapshot(
        account: null,
        session: null,
        googleSupported: capability.isSupported,
        googleConfigured: capability.isConfigured,
        googleAvailabilityMessage: capability.message,
      );
    }

    final session = await _sessionStore.read();
    if (session == null) {
      return AuthSnapshot(
        account: null,
        session: null,
        googleSupported: capability.isSupported,
        googleConfigured: capability.isConfigured,
        googleAvailabilityMessage: capability.message,
      );
    }

    try {
      final response = await _apiClient.get('/auth/me');
      final account = _accountFromUserJson(
        response['user'] as Map<String, dynamic>,
      );
      return AuthSnapshot(
        account: account,
        session: AuthSession(
          userId: account.id,
          signedInAt: session.expiresAt,
          method: AuthSignInMethod.password,
        ),
        googleSupported: capability.isSupported,
        googleConfigured: capability.isConfigured,
        googleAvailabilityMessage: capability.message,
      );
    } catch (_) {
      await _sessionStore.clear();
      return AuthSnapshot(
        account: null,
        session: null,
        googleSupported: capability.isSupported,
        googleConfigured: capability.isConfigured,
        googleAvailabilityMessage: capability.message,
      );
    }
  }

  @override
  Future<AuthActionResult> registerWithPassword({
    required String displayName,
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      '/auth/register',
      authenticated: false,
      body: {'name': displayName, 'email': email, 'password': password},
    );
    await _sessionStore.write(sessionFromAuthResponse(response));
    return const AuthActionResult(
      message: 'Conta criada no servidor e sincronizacao habilitada.',
      createdAccount: true,
    );
  }

  @override
  Future<AuthActionResult> signInWithPassword({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      '/auth/login',
      authenticated: false,
      body: {'email': email, 'password': password},
    );
    await _sessionStore.write(sessionFromAuthResponse(response));
    return const AuthActionResult(
      message: 'Login no servidor realizado com sucesso.',
    );
  }

  @override
  Future<AuthActionResult> signInWithGoogle() async {
    final identity = await _googleAuthService.authenticate();
    return signInWithGoogleIdentity(identity);
  }

  @override
  Future<AuthActionResult> signInWithGoogleIdentity(
    GoogleAuthIdentity identity,
  ) async {
    final idToken = identity.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw const AppException(
        'O Google nao retornou idToken para autenticar no servidor.',
      );
    }

    final response = await _apiClient.post(
      '/auth/google',
      authenticated: false,
      body: {'idToken': idToken, 'name': identity.displayName},
    );
    await _sessionStore.write(sessionFromAuthResponse(response));
    return const AuthActionResult(
      message: 'Login com Google no servidor realizado com sucesso.',
    );
  }

  @override
  Future<AuthActionResult> requestPasswordReset({required String email}) async {
    final response = await _apiClient.post(
      '/auth/password/forgot',
      authenticated: false,
      body: {'email': email},
    );
    return AuthActionResult(
      message:
          'Se o email existir no servidor, um token de recuperacao sera enviado.',
      recoveryCode: response['devResetToken'] as String?,
    );
  }

  @override
  Future<AuthActionResult> resetPasswordWithRecoveryCode({
    required String email,
    required String recoveryCode,
    required String newPassword,
  }) async {
    await _apiClient.post(
      '/auth/password/reset',
      authenticated: false,
      body: {'token': recoveryCode, 'newPassword': newPassword},
    );
    return const AuthActionResult(
      message: 'Senha redefinida no servidor. Entre novamente.',
    );
  }

  @override
  Future<AuthActionResult> resetPasswordWithGoogle({
    required String email,
    required String newPassword,
  }) async {
    throw const AppException(
      'Redefinicao por Google sera feita pelo servidor de email/Google na proxima etapa.',
    );
  }

  @override
  Future<void> signOut() async {
    final session = await _sessionStore.read();
    if (session != null) {
      try {
        await _apiClient.post(
          '/auth/logout',
          body: {'refreshToken': session.refreshToken},
        );
      } catch (_) {
        // Logout local continua mesmo se o servidor estiver indisponivel.
      }
    }
    await _sessionStore.clear();
    await _googleAuthService.signOut();
  }

  AuthAccount _accountFromUserJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    return AuthAccount(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['name'] as String? ?? 'Usuario',
      recoveryCodeHash: 'remote',
      recoveryCodeSalt: 'remote',
      linkedGoogleEmail: json['googleEmail'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? now,
      updatedAt: now,
    );
  }
}
