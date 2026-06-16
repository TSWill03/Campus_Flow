// Signature: dev.tswicolly03

import '../../domain/entities/auth_action_result.dart';
import '../../domain/entities/auth_snapshot.dart';
import '../../domain/entities/google_auth_identity.dart';
import '../../domain/repositories/auth_repository.dart';

/// Repositorio de transicao entre MVP offline e produto com servidor.
///
/// A UI conversa apenas com AuthRepository. Por isso da para trocar entre auth
/// local e auth remota sem reescrever telas de login, recuperacao ou sessao.
class HybridAuthRepository implements AuthRepository {
  HybridAuthRepository({
    required AuthRepository localRepository,
    required AuthRepository remoteRepository,
    required bool useRemote,
  }) : _localRepository = localRepository,
       _remoteRepository = remoteRepository,
       _useRemote = useRemote;

  final AuthRepository _localRepository;
  final AuthRepository _remoteRepository;
  final bool _useRemote;

  AuthRepository get _activeRepository =>
      _useRemote ? _remoteRepository : _localRepository;

  @override
  Future<AuthSnapshot> loadSnapshot() => _activeRepository.loadSnapshot();

  @override
  Future<AuthActionResult> registerWithPassword({
    required String displayName,
    required String email,
    required String password,
  }) {
    return _activeRepository.registerWithPassword(
      displayName: displayName,
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthActionResult> signInWithPassword({
    required String email,
    required String password,
  }) {
    return _activeRepository.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthActionResult> signInWithGoogle() {
    return _activeRepository.signInWithGoogle();
  }

  @override
  Future<AuthActionResult> signInWithGoogleIdentity(
    GoogleAuthIdentity identity,
  ) {
    return _activeRepository.signInWithGoogleIdentity(identity);
  }

  @override
  Future<AuthActionResult> requestPasswordReset({required String email}) {
    return _activeRepository.requestPasswordReset(email: email);
  }

  @override
  Future<AuthActionResult> resetPasswordWithRecoveryCode({
    required String email,
    required String recoveryCode,
    required String newPassword,
  }) {
    return _activeRepository.resetPasswordWithRecoveryCode(
      email: email,
      recoveryCode: recoveryCode,
      newPassword: newPassword,
    );
  }

  @override
  Future<AuthActionResult> resetPasswordWithGoogle({
    required String email,
    required String newPassword,
  }) {
    return _activeRepository.resetPasswordWithGoogle(
      email: email,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> signOut() => _activeRepository.signOut();
}
