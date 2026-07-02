import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF5A75FF); // Neon Blue
  static const Color primaryLight = Color(0xFF8C9EFF);
  static const Color primaryDark = Color(0xFF2B3A8C);
  static const Color accent = Color(0xFF9D4EDD); // Neon Purple
  
  // Background Colors
  static const Color background = Color(0xFF090A14); // Deep Navy Black
  static const Color surface = Color(0xFF141626); // Card background
  static const Color surfaceLight = Color(0xFF1E2138); 
  static const Color glassmorphism = Color(0x33141626); // Transparent surface
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8A8FA1);
  static const Color textMuted = Color(0xFF5A5E70);
  
  // Status Colors
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF3D00);
  static const Color info = Color(0xFF00B0FF);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF5A75FF), Color(0xFF9D4EDD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF090A14), Color(0xFF0C1021)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}