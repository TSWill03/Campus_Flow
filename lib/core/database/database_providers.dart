import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_database.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('SharedPreferences nao inicializado.'),
);

final appDatabaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('AppDatabase nao inicializado.'),
);
