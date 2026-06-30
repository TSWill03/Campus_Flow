// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../database/database_providers.dart';
import 'error_report_service.dart';

final errorReportServiceProvider = Provider<ErrorReportService>((ref) {
  return ErrorReportService(
    sharedPreferences: ref.watch(sharedPreferencesProvider),
    sessionStore: ref.watch(apiSessionStoreProvider),
  );
});

final queuedErrorReportCountProvider = FutureProvider<int>((ref) {
  return ref.watch(errorReportServiceProvider).queuedReportCount();
});
