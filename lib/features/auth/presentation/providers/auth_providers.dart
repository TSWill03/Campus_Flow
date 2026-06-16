// Signature: dev.tswicolly03

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_session_store.dart';
import '../../../../core/network/api_settings.dart';
import '../../../../core/error/app_exception.dart';
import '../../data/repositories/hybrid_auth_repository.dart';
import '../../data/repositories/local_auth_repository.dart';
import '../../data/repositories/remote_auth_repository.dart';
import '../../data/services/flutter_secure_auth_store.dart';
import '../../data/services/google_auth_service.dart';
import '../../data/services/password_hasher.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_view_state.dart';

final authSecureStoreProvider = Provider<FlutterSecureAuthStore>(
  (ref) => FlutterSecureAuthStore(),
);

final passwordHasherProvider = Provider<PasswordHasher>(
  (ref) => PasswordHasher(),
);

final googleAuthServiceProvider = Provider<GoogleAuthService>(
  (ref) => PlatformGoogleAuthService(),
);

final apiSessionStoreProvider = Provider<ApiSessionStore>((ref) {
  return ApiSessionStore(secureStore: ref.watch(authSecureStoreProvider));
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    settings: ref.watch(apiSettingsControllerProvider),
    sessionStore: ref.watch(apiSessionStoreProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final localRepository = LocalAuthRepository(
    secureStore: ref.watch(authSecureStoreProvider),
    passwordHasher: ref.watch(passwordHasherProvider),
    googleAuthService: ref.watch(googleAuthServiceProvider),
  );
  final remoteRepository = RemoteAuthRepository(
    apiClient: ref.watch(apiClientProvider),
    sessionStore: ref.watch(apiSessionStoreProvider),
    settings: ref.watch(apiSettingsControllerProvider),
    googleAuthService: ref.watch(googleAuthServiceProvider),
  );
  final settings = ref.watch(apiSettingsControllerProvider);
  return HybridAuthRepository(
    localRepository: localRepository,
    remoteRepository: remoteRepository,
    useRemote: settings.hasServer,
  );
});

class AuthController extends Notifier<AuthViewState> {
  bool _didBootstrap = false;

  @override
  AuthViewState build() {
    if (!_didBootstrap) {
      _didBootstrap = true;
      Future<void>.microtask(refresh);
    }
    return const AuthViewState.loading();
  }

  Future<void> refresh() async {
    final current = state;
    state = current.copyWith(isLoading: true, clearError: true);

    try {
      final snapshot = await ref.read(authRepositoryProvider).loadSnapshot();
      state = AuthViewState(
        isLoading: false,
        account: snapshot.account,
        session: snapshot.session,
        googleSupported: snapshot.googleSupported,
        googleConfigured: snapshot.googleConfigured,
        googleAvailabilityMessage: snapshot.googleAvailabilityMessage,
      );
    } catch (error) {
      state = AuthViewState(
        isLoading: false,
        account: current.account,
        session: current.session,
        googleSupported: current.googleSupported,
        googleConfigured: current.googleConfigured,
        googleAvailabilityMessage: current.googleAvailabilityMessage,
        errorMessage: error is AppException
            ? error.message
            : 'Nao foi possivel carregar a autenticacao: $error',
      );
    }
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    await refresh();
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthViewState>(
  AuthController.new,
);

final authRouterRefreshProvider = Provider<ValueNotifier<int>>((ref) {
  final notifier = ValueNotifier<int>(0);
  ref.listen<AuthViewState>(authControllerProvider, (previous, next) {
    if (previous == next) {
      return;
    }
    notifier.value++;
  });
  ref.onDispose(notifier.dispose);
  return notifier;
});
