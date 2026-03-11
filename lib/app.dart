import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/color_profile_controller.dart';
import 'core/theme/theme_mode_controller.dart';

class CampusFlowApp extends ConsumerWidget {
  const CampusFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themePreference = ref.watch(themeModeControllerProvider);
    final colorProfile = ref.watch(colorProfileControllerProvider);

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
