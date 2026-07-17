import 'package:flutter/material.dart';
import 'package:rto_assmant/models/theme_model.dart';

class GlassThemeData {
  final String id;
  final String name;
  final String backgroundImage;
  final double blurStrength;
  final double overlayOpacity;
  final Color glassTint;
  final Color accentColor;
  final List<Color> gradientColors;
  final String animationStyle; // 'fade', 'scale', 'slide'
  final int price;
  final String currency; // 'coins', 'gems'

  const GlassThemeData({
    required this.id,
    required this.name,
    required this.backgroundImage,
    this.blurStrength = 20.0,
    this.overlayOpacity = 0.1,
    this.glassTint = Colors.white,
    this.accentColor = const Color(0xFF8A4FFF),
    this.gradientColors = const [Color(0xFF8A4FFF), Color(0xFF6A4C93)],
    this.animationStyle = 'fade',
    required this.price,
    required this.currency,
  });

  // Dynamic builder that constructs GlassThemeData list directly from ThemeModel.availableThemes
  static List<GlassThemeData> get availableThemes {
    return ThemeModel.availableThemes.map((model) {
      double blur = 20.0;
      double opacity = 0.10;
      Color tint = Colors.white;
      Color accent = const Color(0xFF8A4FFF);
      List<Color> gradient = const [Color(0xFF8A4FFF), Color(0xFF6A4C93)];

      switch (model.id) {
        case 'default':
          blur = 25.0;
          opacity = 0.12;
          accent = const Color(0xFFB19CD9);
          gradient = const [Color(0xFF8A4FFF), Color(0xFF6A4C93)];
          break;
        case 'neon':
          blur = 18.0;
          opacity = 0.08;
          tint = const Color(0xFF1F1D2C);
          accent = const Color(0xFF00FFCC);
          gradient = const [Color(0xFF00FFCC), Color(0xFF0099FF)];
          break;
        case 'ocean':
          blur = 22.0;
          opacity = 0.15;
          tint = const Color(0xFF0A192F);
          accent = const Color(0xFF172A45);
          gradient = const [Color(0xFF00D2FF), Color(0xFF0066FF)];
          break;
        case 'gold':
          blur = 20.0;
          opacity = 0.10;
          accent = const Color(0xFFFFB300);
          gradient = const [Color(0xFFFFB300), Color(0xFFE65100)];
          break;
        case 'emerald':
          blur = 20.0;
          opacity = 0.11;
          accent = const Color(0xFF00C853);
          gradient = const [Color(0xFF00C853), Color(0xFF1B5E20)];
          break;
        case 'sunset':
          blur = 24.0;
          opacity = 0.13;
          tint = const Color(0xFF2E0000);
          accent = const Color(0xFFFF1744);
          gradient = const [Color(0xFFFF1744), Color(0xFFD50000)];
          break;
        case 'candy':
          blur = 18.0;
          opacity = 0.09;
          accent = const Color(0xFFFF4081);
          gradient = const [Color(0xFFFF4081), Color(0xFFF50057)];
          break;
        case 'mystic_dust':
          blur = 25.0;
          opacity = 0.16;
          tint = const Color(0xFF1E1E2E);
          accent = const Color(0xFFE040FB);
          gradient = const [Color(0xFFE040FB), Color(0xFF651FFF)];
          break;
        case 'frozen_glacier':
          blur = 22.0;
          opacity = 0.10;
          accent = const Color(0xFF00E5FF);
          gradient = const [Color(0xFF00E5FF), Color(0xFF00B0FF)];
          break;
        case 'cherry_blossom':
          blur = 18.0;
          opacity = 0.08;
          accent = const Color(0xFFFF8A80);
          gradient = const [Color(0xFFFF8A80), Color(0xFFFF5252)];
          break;
        case 'space_horizon':
          blur = 28.0;
          opacity = 0.16;
          tint = const Color(0xFF0A001A);
          accent = const Color(0xFF00E5FF);
          gradient = const [Color(0xFF00E5FF), Color(0xFFD500F9)];
          break;
        case 'galaxy':
          blur = 30.0;
          opacity = 0.18;
          tint = const Color(0xFF150030);
          accent = const Color(0xFFFF007F);
          gradient = const [Color(0xFFFF007F), Color(0xFF7F00FF)];
          break;
        case 'forest':
          blur = 20.0;
          opacity = 0.10;
          tint = const Color(0xFF0B1B10);
          accent = const Color(0xFF00E676);
          gradient = const [Color(0xFF00E676), Color(0xFF00838F)];
          break;
        case 'royal':
          blur = 26.0;
          opacity = 0.14;
          accent = const Color(0xFFD500F9);
          gradient = const [Color(0xFFD500F9), Color(0xFF4A148C)];
          break;
        case 'cyber':
          blur = 15.0;
          opacity = 0.08;
          tint = const Color(0xFF0F001A);
          accent = const Color(0xFF39FF14);
          gradient = const [Color(0xFF39FF14), Color(0xFFFF007F)];
          break;
        case 'midnight_blue':
          blur = 28.0;
          opacity = 0.15;
          tint = const Color(0xFF050014);
          accent = const Color(0xFF2979FF);
          gradient = const [Color(0xFF2979FF), Color(0xFF1A237E)];
          break;
        case 'pastel_dream':
          blur = 20.0;
          opacity = 0.07;
          accent = const Color(0xFF80DEEA);
          gradient = const [Color(0xFF80DEEA), Color(0xFFB39DDB)];
          break;
        case 'volcanic_fire':
          blur = 24.0;
          opacity = 0.15;
          tint = const Color(0xFF1E0000);
          accent = const Color(0xFFFF3D00);
          gradient = const [Color(0xFFFF3D00), Color(0xFFDD2C00)];
          break;
        case 'warm_desert':
          blur = 20.0;
          opacity = 0.10;
          accent = const Color(0xFFFFAB40);
          gradient = const [Color(0xFFFFAB40), Color(0xFFFF6D00)];
          break;
        case 'cyber_orange':
          blur = 16.0;
          opacity = 0.08;
          tint = const Color(0xFF1F0F00);
          accent = const Color(0xFFFF6D00);
          gradient = const [Color(0xFFFF6D00), Color(0xFFFFD600)];
          break;
        case 'mystic_rose':
          blur = 20.0;
          opacity = 0.11;
          accent = const Color(0xFFFF4081);
          gradient = const [Color(0xFFFF4081), Color(0xFFE91E63)];
          break;
        case 'aurora_glow':
          blur = 24.0;
          opacity = 0.12;
          tint = const Color(0xFF001A0F);
          accent = const Color(0xFF00E676);
          gradient = const [Color(0xFF00E676), Color(0xFF00B0FF)];
          break;
      }

      return GlassThemeData(
        id: model.id,
        name: model.name,
        backgroundImage: model.image,
        blurStrength: blur,
        overlayOpacity: opacity,
        glassTint: tint,
        accentColor: accent,
        gradientColors: gradient,
        price: model.price,
        currency: model.currency == 'diamonds' ? 'gems' : model.currency,
      );
    }).toList();
  }
}
