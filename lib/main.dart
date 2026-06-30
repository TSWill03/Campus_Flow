// Signature: dev.tswicolly03

import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/database/app_database.dart';
import 'core/database/database_providers.dart';
import 'core/feedback/error_report_service.dart';

Future<void> main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Dependencias globais sao carregadas antes do app subir para que Riverpod
      // consiga entregar a mesma instancia de preferencias e banco para todas as
      // features. Isso evita singletons soltos e facilita testes com overrides.
      final sharedPreferences = await SharedPreferences.getInstance();
      final database = AppDatabase();
      final errorReportService = createGlobalErrorReportService(
        sharedPreferences,
      );
      GlobalErrorReporter.attach(errorReportService);

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        GlobalErrorReporter.captureFlutterError(details);
      };
      PlatformDispatcher.instance.onError = (error, stackTrace) {
        GlobalErrorReporter.capture(error, stackTrace);
        return true;
      };

      runApp(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(sharedPreferences),
            appDatabaseProvider.overrideWithValue(database),
          ],
          child: const CampusFlowApp(),
        ),
      );
    },
    (error, stackTrace) {
      GlobalErrorReporter.capture(error, stackTrace);
    },
  );
}
