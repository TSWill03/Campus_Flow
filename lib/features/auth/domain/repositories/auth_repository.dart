// Signature: dev.tswicolly03

import '../entities/auth_action_result.dart';
import '../entities/auth_snapshot.dart';
import '../entities/google_auth_identity.dart';

abstract class AuthRepository {
  Future<AuthSnapshot> loadSnapshot();

  Future<AuthActionResult> registerWithPassword({
    required String displayName,
    required String email,
    required String password,
  });

  Future<AuthActionResult> signInWithPassword({
    required String email,
    required String password,
  });

  Future<AuthActionResult> signInWithGoogle();

  Future<AuthActionResult> signInWithGoogleIdentity(
    GoogleAuthIdentity identity,
  );

  Future<AuthActionResult> resetPasswordWithRecoveryCode({
    required String email,
    required String recoveryCode,
    required String newPassword,
  });

  Future<AuthActionResult> requestPasswordReset({required String email});

  Future<AuthActionResult> resetPasswordWithGoogle({
    required String email,
    required String newPassword,
  });

  Future<void> signOut();
}
