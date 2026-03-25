// Signature: dev.tswicolly03

import '../../domain/entities/auth_account.dart';
import '../../domain/entities/auth_session.dart';

class AuthViewState {
  const AuthViewState({
    required this.isLoading,
    required this.googleSupported,
    required this.googleConfigured,
    this.account,
    this.session,
    this.googleAvailabilityMessage,
    this.errorMessage,
  });

  const AuthViewState.loading()
      : isLoading = true,
        account = null,
        session = null,
        googleSupported = false,
        googleConfigured = false,
        googleAvailabilityMessage = null,
        errorMessage = null;

  final bool isLoading;
  final AuthAccount? account;
  final AuthSession? session;
  final bool googleSupported;
  final bool googleConfigured;
  final String? googleAvailabilityMessage;
  final String? errorMessage;

  bool get hasAccount => account != null;
  bool get isAuthenticated =>
      account != null && session != null && session!.userId == account!.id;

  AuthViewState copyWith({
    bool? isLoading,
    AuthAccount? account,
    AuthSession? session,
    bool clearSession = false,
    bool? googleSupported,
    bool? googleConfigured,
    String? googleAvailabilityMessage,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthViewState(
      isLoading: isLoading ?? this.isLoading,
      account: account ?? this.account,
      session: clearSession ? null : session ?? this.session,
      googleSupported: googleSupported ?? this.googleSupported,
      googleConfigured: googleConfigured ?? this.googleConfigured,
      googleAvailabilityMessage:
          googleAvailabilityMessage ?? this.googleAvailabilityMessage,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
