// Signature: dev.tswicolly03

import 'auth_account.dart';
import 'auth_session.dart';

class AuthSnapshot {
  const AuthSnapshot({
    required this.account,
    required this.session,
    required this.googleSupported,
    required this.googleConfigured,
    this.googleAvailabilityMessage,
  });

  final AuthAccount? account;
  final AuthSession? session;
  final bool googleSupported;
  final bool googleConfigured;
  final String? googleAvailabilityMessage;

  bool get hasAccount => account != null;
  bool get isAuthenticated =>
      account != null && session != null && session!.userId == account!.id;
}
