import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6A4C93),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: Colors.transparent,
      useMaterial3: true,
      fontFamily: 'Inter',
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6A4C93),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.transparent,
      useMaterial3: true,
      fontFamily: 'Inter',
    );
  }
}
