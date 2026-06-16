// Signature: dev.tswicolly03

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_database.dart';

// Estes providers sao preenchidos em `main.dart`. Em testes, eles tambem podem
// ser substituidos por instancias em memoria, mantendo as features desacopladas
// de construtores globais.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('SharedPreferences nao inicializado.'),
);

final appDatabaseProvider = Provider<AppDatabase>(
  (ref) => throw UnimplementedError('AppDatabase nao inicializado.'),
);
