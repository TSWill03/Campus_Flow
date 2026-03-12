// Signature: dev.tswicolly03

enum ThemePreference {
  system,
  light,
  dark,
}

extension ThemePreferenceX on ThemePreference {
  String get label => switch (this) {
        ThemePreference.system => 'Seguir sistema',
        ThemePreference.light => 'Claro',
        ThemePreference.dark => 'Escuro',
      };
}
