// Signature: dev.tswicolly03

import 'package:flutter_test/flutter_test.dart';

import 'package:campus_flow/core/error/app_exception.dart';
import 'package:campus_flow/features/auth/data/repositories/local_auth_repository.dart';
import 'package:campus_flow/features/auth/data/services/auth_secure_store.dart';
import 'package:campus_flow/features/auth/data/services/google_auth_service.dart';
import 'package:campus_flow/features/auth/data/services/password_hasher.dart';
import 'package:campus_flow/features/auth/domain/entities/google_auth_identity.dart';

class _MemoryAuthSecureStore implements AuthSecureStore {
  final Map<String, String> _store = <String, String>{};

  @override
  Future<void> delete(String key) async {
    _store.remove(key);
  }

  @override
  Future<String?> read(String key) async => _store[key];

  @override
  Future<void> write(String key, String value) async {
    _store[key] = value;
  }
}

class _FakeGoogleAuthService implements GoogleAuthService {
  _FakeGoogleAuthService({required this.identity});

  final GoogleAuthIdentity identity;

  @override
  Stream<GoogleAuthIdentity> get authenticationEvents =>
      const Stream<GoogleAuthIdentity>.empty();

  @override
  GoogleAuthCapability get capability =>
      GoogleAuthCapability(isSupported: true, isConfigured: true);

  @override
  Future<void> initialize() async {}

  @override
  Future<GoogleAuthIdentity> authenticate() async => identity;

  @override
  Future<void> signOut() async {}
}

void main() {
  group('LocalAuthRepository', () {
    late _MemoryAuthSecureStore secureStore;
    late PasswordHasher passwordHasher;

    setUp(() {
      secureStore = _MemoryAuthSecureStore();
      passwordHasher = PasswordHasher();
    });

    test('cria conta local, guarda sessao e permite login por senha', () async {
      final repository = LocalAuthRepository(
        secureStore: secureStore,
        passwordHasher: passwordHasher,
        googleAuthService: _FakeGoogleAuthService(
          identity: const GoogleAuthIdentity(
            email: 'aluno@example.com',
            displayName: 'Aluno',
          ),
        ),
      );

      final registerResult = await repository.registerWithPassword(
        displayName: 'Aluno Teste',
        email: 'aluno@example.com',
        password: 'senha-forte-123',
      );

      expect(registerResult.recoveryCode, isNotNull);
      expect(registerResult.createdAccount, isTrue);

      final snapshotAfterRegister = await repository.loadSnapshot();
      expect(snapshotAfterRegister.isAuthenticated, isTrue);
      expect(snapshotAfterRegister.account?.email, 'aluno@example.com');

      await repository.signOut();
      final signInResult = await repository.signInWithPassword(
        email: 'aluno@example.com',
        password: 'senha-forte-123',
      );

      expect(signInResult.message, contains('Login realizado'));
      final snapshotAfterLogin = await repository.loadSnapshot();
      expect(snapshotAfterLogin.isAuthenticated, isTrue);
      expect(snapshotAfterLogin.session, isNotNull);
    });

    test('redefine a senha com codigo de recuperacao', () async {
      final repository = LocalAuthRepository(
        secureStore: secureStore,
        passwordHasher: passwordHasher,
        googleAuthService: _FakeGoogleAuthService(
          identity: const GoogleAuthIdentity(
            email: 'aluno@example.com',
            displayName: 'Aluno',
          ),
        ),
      );

      final registerResult = await repository.registerWithPassword(
        displayName: 'Aluno Teste',
        email: 'aluno@example.com',
        password: 'senha-antiga-123',
      );
      await repository.signOut();

      await repository.resetPasswordWithRecoveryCode(
        email: 'aluno@example.com',
        recoveryCode: registerResult.recoveryCode!,
        newPassword: 'senha-nova-456',
      );

      await expectLater(
        repository.signInWithPassword(
          email: 'aluno@example.com',
          password: 'senha-antiga-123',
        ),
        throwsA(isA<AppException>()),
      );

      final signInResult = await repository.signInWithPassword(
        email: 'aluno@example.com',
        password: 'senha-nova-456',
      );
      expect(signInResult.message, contains('Login realizado'));
    });

    test('cria conta com Google e permite definir senha depois', () async {
      final repository = LocalAuthRepository(
        secureStore: secureStore,
        passwordHasher: passwordHasher,
        googleAuthService: _FakeGoogleAuthService(
          identity: const GoogleAuthIdentity(
            email: 'google@example.com',
            displayName: 'Aluno Google',
          ),
        ),
      );

      final googleResult = await repository.signInWithGoogle();
      expect(googleResult.createdAccount, isTrue);
      expect(googleResult.recoveryCode, isNotNull);

      await repository.signOut();
      await repository.resetPasswordWithGoogle(
        email: 'google@example.com',
        newPassword: 'senha-local-789',
      );

      final passwordResult = await repository.signInWithPassword(
        email: 'google@example.com',
        password: 'senha-local-789',
      );
      expect(passwordResult.message, contains('Login realizado'));
    });
  });
}
