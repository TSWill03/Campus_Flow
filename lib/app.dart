// Signature: dev.tswicolly03

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/sync/remote_sync_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/color_profile_controller.dart';
import 'core/theme/theme_mode_controller.dart';
import 'features/auth/presentation/providers/auth_providers.dart';

final _autoSyncStartedProvider = StateProvider<bool>((ref) => false);

/// Widget raiz do CampusFlow.
///
/// Ele concentra configuracoes globais que precisam valer para o app inteiro:
/// tema claro/escuro, idioma, roteamento e sincronizacao automatica apos login.
class CampusFlowApp extends ConsumerWidget {
  const CampusFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themePreference = ref.watch(themeModeControllerProvider);
    final colorProfile = ref.watch(colorProfileControllerProvider);
    final authState = ref.watch(authControllerProvider);
    final autoSyncStarted = ref.watch(_autoSyncStartedProvider);

    // A sincronizacao e disparada fora do build com microtask para manter a UI
    // responsiva. Se a internet ou o servidor falhar, o app continua offline e
    // a tela de ajustes mostra a fila pendente para o usuario tentar depois.
    if (authState.isAuthenticated && !autoSyncStarted) {
      Future<void>.microtask(() async {
        ref.read(_autoSyncStartedProvider.notifier).state = true;
        try {
          await ref.read(remoteSyncServiceProvider).syncNow();
        } catch (_) {
          // A tela de ajustes ainda permite sincronizar manualmente e ver falhas.
        }
      });
    } else if (!authState.isAuthenticated && autoSyncStarted) {
      Future<void>.microtask(() {
        ref.read(_autoSyncStartedProvider.notifier).state = false;
      });
    }

    return MaterialApp.router(
      title: 'CampusFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(colorProfile),
      darkTheme: AppTheme.darkTheme(colorProfile),
      themeMode: themePreference.themeMode,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
