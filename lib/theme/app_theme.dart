import 'package:flutter/material.dart';

class AppTheme {
  // Paleta MALLKUBOX
  static const Color primary   = Color(0xFFFF6B00); // Naranja intenso
  static const Color purple    = Color(0xFF7B2FBE); // Púrpura
  static const Color cyan      = Color(0xFF00D4FF); // Cyan
  static const Color red       = Color(0xFFFF1744); // Rojo
  static const Color teal      = Color(0xFF00BFA5); // Teal
  static const Color bgDark    = Color(0xFF0D0D1A); // Fondo principal
  static const Color surface   = Color(0xFF161628); // Superficies
  static const Color surfaceHigh = Color(0xFF1E1E35); // Superficie elevada

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgDark,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: cyan,
      surface: surface,
      error: red,
    ),
  );
}
