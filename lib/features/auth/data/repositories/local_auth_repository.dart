// Signature: dev.tswicolly03

import 'dart:convert';

import '../../../../core/error/app_exception.dart';
import '../../domain/entities/auth_account.dart';
import '../../domain/entities/auth_action_result.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_snapshot.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/auth_secure_store.dart';
import '../services/google_auth_service.dart';
import '../services/password_hasher.dart';

class LocalAuthRepository implements AuthRepository {
  LocalAuthRepository({
    required AuthSecureStore secureStore,
    required PasswordHasher passwordHasher,
    required GoogleAuthService googleAuthService,
    String accountStorageKey = 'campusflow.auth.account',
    String sessionStorageKey = 'campusflow.auth.session',
  })  : _secureStore = secureStore,
        _passwordHasher = passwordHasher,
        _googleAuthService = googleAuthService,
        _accountStorageKey = accountStorageKey,
        _sessionStorageKey = sessionStorageKey;

  final AuthSecureStore _secureStore;
  final PasswordHasher _passwordHasher;
  final GoogleAuthService _googleAuthService;
  final String _accountStorageKey;
  final String _sessionStorageKey;

  @override
  Future<AuthSnapshot> loadSnapshot() async {
    final account = await _readAccount();
    final session = await _readSession();
    final capability = _googleAuthService.capability;

    if (account == null) {
      await _clearSession();
      return AuthSnapshot(
        account: null,
        session: null,
        googleSupported: capability.isSupported,
        googleConfigured: capability.isConfigured,
        googleAvailabilityMessage: capability.message,
      );
    }

    if (session != null && session.userId != account.id) {
      await _clearSession();
      return AuthSnapshot(
        account: account,
        session: null,
        googleSupported: capability.isSupported,
        googleConfigured: capability.isConfigured,
        googleAvailabilityMessage: capability.message,
      );
    }

    return AuthSnapshot(
      account: account,
      session: session,
      googleSupported: capability.isSupported,
      googleConfigured: capability.isConfigured,
      googleAvailabilityMessage: capability.message,
    );
  }

  @override
  Future<AuthActionResult> registerWithPassword({
    required String displayName,
    required String email,
    required String password,
  }) async {
    final existing = await _readAccount();
    final normalizedEmail = _passwordHasher.normalizeEmail(email);
    final cleanedName = displayName.trim();
    if (cleanedName.isEmpty) {
      throw const AppException('Informe seu nome para criar a conta.');
    }
    if (existing != null) {
      throw const AppException(
        'Ja existe uma conta local neste dispositivo. Entre com ela ou redefina a senha.',
      );
    }

    final now = DateTime.now();
    final passwordSalt = _passwordHasher.generateSalt();
    final recoverySalt = _passwordHasher.generateSalt();
    final recoveryCode = _passwordHasher.generateRecoveryCode();
    final passwordHash = await _passwordHasher.hash(
      value: password,
      salt: passwordSalt,
    );
    final recoveryCodeHash = await _passwordHasher.hash(
      value: _passwordHasher.normalizeRecoveryCode(recoveryCode),
      salt: recoverySalt,
    );

    final account = AuthAccount(
      id: _passwordHasher.generateSalt(),
      email: normalizedEmail,
      displayName: cleanedName,
      passwordHash: passwordHash,
      passwordSalt: passwordSalt,
      recoveryCodeHash: recoveryCodeHash,
      recoveryCodeSalt: recoverySalt,
      createdAt: now,
      updatedAt: now,
    );

    await _saveAccount(account);
    await _saveSession(
      AuthSession(
        userId: account.id,
        signedInAt: now,
        method: AuthSignInMethod.password,
      ),
    );

    return AuthActionResult(
      message: 'Conta criada com sucesso.',
      recoveryCode: recoveryCode,
      createdAccount: true,
    );
  }

  @override
  Future<AuthActionResult> signInWithPassword({
    required String email,
    required String password,
  }) async {
    final account = await _requireAccount();
    final normalizedEmail = _passwordHasher.normalizeEmail(email);
    if (account.email != normalizedEmail) {
      throw const AppException(
        'Este dispositivo esta associado a outra conta local.',
      );
    }
    if (!account.hasPassword) {
      throw const AppException(
        'Esta conta ainda nao tem senha local. Entre com Google ou redefina a senha.',
      );
    }

    final providedHash = await _passwordHasher.hash(
      value: password,
      salt: account.passwordSalt!,
    );
    if (providedHash != account.passwordHash) {
      throw const AppException('Email ou senha invalidos.');
    }

    await _saveSession(
      AuthSession(
        userId: account.id,
        signedInAt: DateTime.now(),
        method: AuthSignInMethod.password,
      ),
    );

    return const AuthActionResult(
      message: 'Login realizado com sucesso.',
    );
  }

  @override
  Future<AuthActionResult> signInWithGoogle() async {
    final identity = await _googleAuthService.authenticate();
    final normalizedEmail = _passwordHasher.normalizeEmail(identity.email);
    final existing = await _readAccount();
    final now = DateTime.now();

    if (existing == null) {
      final recoverySalt = _passwordHasher.generateSalt();
      final recoveryCode = _passwordHasher.generateRecoveryCode();
      final recoveryHash = await _passwordHasher.hash(
        value: _passwordHasher.normalizeRecoveryCode(recoveryCode),
        salt: recoverySalt,
      );
      final account = AuthAccount(
        id: _passwordHasher.generateSalt(),
        email: normalizedEmail,
        displayName: identity.displayName,
        recoveryCodeHash: recoveryHash,
        recoveryCodeSalt: recoverySalt,
        linkedGoogleEmail: normalizedEmail,
        linkedGoogleDisplayName: identity.displayName,
        photoUrl: identity.photoUrl,
        createdAt: now,
        updatedAt: now,
      );

      await _saveAccount(account);
      await _saveSession(
        AuthSession(
          userId: account.id,
          signedInAt: now,
          method: AuthSignInMethod.google,
        ),
      );

      return AuthActionResult(
        message:
            'Conta criada com Google. Guarde o codigo de recuperacao para redefinir sua senha local depois.',
        recoveryCode: recoveryCode,
        createdAccount: true,
      );
    }

    final accountEmail = _passwordHasher.normalizeEmail(existing.email);
    final linkedGoogleEmail = existing.linkedGoogleEmail == null
        ? null
        : _passwordHasher.normalizeEmail(existing.linkedGoogleEmail!);

    if (linkedGoogleEmail != null && linkedGoogleEmail != normalizedEmail) {
      throw const AppException(
        'A conta Google informada nao corresponde ao perfil vinculado neste dispositivo.',
      );
    }

    if (linkedGoogleEmail == null && accountEmail != normalizedEmail) {
      throw const AppException(
        'O email do Google nao coincide com a conta local existente neste dispositivo.',
      );
    }

    final updatedAccount = existing.copyWith(
      linkedGoogleEmail: normalizedEmail,
      linkedGoogleDisplayName: identity.displayName,
      photoUrl: identity.photoUrl,
      updatedAt: now,
    );
    await _saveAccount(updatedAccount);
    await _saveSession(
      AuthSession(
        userId: updatedAccount.id,
        signedInAt: now,
        method: AuthSignInMethod.google,
      ),
    );

    return const AuthActionResult(
      message: 'Login com Google realizado com sucesso.',
    );
  }

  @override
  Future<AuthActionResult> resetPasswordWithRecoveryCode({
    required String email,
    required String recoveryCode,
    required String newPassword,
  }) async {
    final account = await _requireMatchingAccount(email);
    final normalizedRecoveryCode =
        _passwordHasher.normalizeRecoveryCode(recoveryCode);
    final providedHash = await _passwordHasher.hash(
      value: normalizedRecoveryCode,
      salt: account.recoveryCodeSalt,
    );

    if (providedHash != account.recoveryCodeHash) {
      throw const AppException('Codigo de recuperacao invalido.');
    }

    await _updatePassword(account, newPassword);

    return const AuthActionResult(
      message: 'Senha redefinida com sucesso. Entre com a nova senha.',
    );
  }

  @override
  Future<AuthActionResult> resetPasswordWithGoogle({
    required String email,
    required String newPassword,
  }) async {
    final account = await _requireMatchingAccount(email);
    final identity = await _googleAuthService.authenticate();
    final normalizedGoogleEmail = _passwordHasher.normalizeEmail(identity.email);
    final allowedGoogleEmail = account.linkedGoogleEmail == null
        ? account.email
        : account.linkedGoogleEmail!;

    if (_passwordHasher.normalizeEmail(allowedGoogleEmail) !=
        normalizedGoogleEmail) {
      throw const AppException(
        'A conta Google autenticada nao corresponde ao perfil vinculado.',
      );
    }

    final linkedAccount = account.copyWith(
      linkedGoogleEmail: normalizedGoogleEmail,
      linkedGoogleDisplayName: identity.displayName,
      photoUrl: identity.photoUrl,
      updatedAt: DateTime.now(),
    );
    await _saveAccount(linkedAccount);
    await _updatePassword(linkedAccount, newPassword);

    return const AuthActionResult(
      message: 'Senha local redefinida com sucesso via Google.',
    );
  }

  @override
  Future<void> signOut() async {
    await _clearSession();
    await _googleAuthService.signOut();
  }

  Future<AuthAccount?> _readAccount() async {
    final raw = await _secureStore.read(_accountStorageKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final json = jsonDecode(raw) as Map<String, dynamic>;
    return AuthAccount.fromJson(json);
  }

  Future<AuthSession?> _readSession() async {
    final raw = await _secureStore.read(_sessionStorageKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final json = jsonDecode(raw) as Map<String, dynamic>;
    return AuthSession.fromJson(json);
  }

  Future<void> _saveAccount(AuthAccount account) {
    return _secureStore.write(_accountStorageKey, jsonEncode(account.toJson()));
  }

  Future<void> _saveSession(AuthSession session) {
    return _secureStore.write(_sessionStorageKey, jsonEncode(session.toJson()));
  }

  Future<void> _clearSession() => _secureStore.delete(_sessionStorageKey);

  Future<AuthAccount> _requireAccount() async {
    final account = await _readAccount();
    if (account == null) {
      throw const AppException(
        'Nenhuma conta local foi criada ainda. Use "Criar conta" para comecar.',
      );
    }
    return account;
  }

  Future<AuthAccount> _requireMatchingAccount(String email) async {
    final account = await _requireAccount();
    final normalizedEmail = _passwordHasher.normalizeEmail(email);
    if (account.email != normalizedEmail) {
      throw const AppException(
        'O email informado nao corresponde a conta local deste dispositivo.',
      );
    }
    return account;
  }

  Future<void> _updatePassword(AuthAccount account, String newPassword) async {
    final passwordSalt = _passwordHasher.generateSalt();
    final passwordHash = await _passwordHasher.hash(
      value: newPassword,
      salt: passwordSalt,
    );
    final updatedAccount = account.copyWith(
      passwordHash: passwordHash,
      passwordSalt: passwordSalt,
      updatedAt: DateTime.now(),
    );
    await _saveAccount(updatedAccount);
    await _clearSession();
  }
}
