import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/enums/theme_preference.dart';
import '../database/database_providers.dart';

class ThemeModeController extends Notifier<ThemePreference> {
  static const _key = 'theme_preference';

  @override
  ThemePreference build() {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    final rawValue = sharedPreferences.getString(_key);

    return ThemePreference.values.firstWhere(
      (value) => value.name == rawValue,
      orElse: () => ThemePreference.system,
    );
  }

  Future<void> updatePreference(ThemePreference preference) async {
    state = preference;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_key, preference.name);
  }
}

final themeModeControllerProvider =
    NotifierProvider<ThemeModeController, ThemePreference>(
  ThemeModeController.new,
);

extension ThemePreferenceThemeModeX on ThemePreference {
  ThemeMode get themeMode => switch (this) {
        ThemePreference.system => ThemeMode.system,
        ThemePreference.light => ThemeMode.light,
        ThemePreference.dark => ThemeMode.dark,
      };
}
