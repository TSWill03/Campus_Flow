import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color_profile.dart';

class AppTheme {
  static ThemeData lightTheme(AppColorProfile profile) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: profile.seedColor,
        brightness: Brightness.light,
        secondary: profile.accentColor,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme),
      scaffoldBackgroundColor: const Color(0xFFF4F7F9),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFBFCFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: base.colorScheme.outlineVariant.withValues(alpha: 0.8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: base.colorScheme.primary, width: 1.2),
        ),
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: base.colorScheme.surface,
      ),
    );
  }

  static ThemeData darkTheme(AppColorProfile profile) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: profile.seedColor,
        brightness: Brightness.dark,
        secondary: profile.accentColor,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme),
      scaffoldBackgroundColor: const Color(0xFF0B1012),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF11181C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: base.colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: base.colorScheme.primary, width: 1.2),
        ),
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: const Color(0xFF10171A),
      ),
    );
  }
}
