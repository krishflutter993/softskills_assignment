import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rto_assmant/widgets/glass_theme.dart';

class ThemeManager extends ChangeNotifier {
  GlassThemeData _equippedTheme = GlassThemeData.availableThemes.first;
  List<String> _ownedThemes = [GlassThemeData.availableThemes.first.id];

  GlassThemeData get equippedTheme => _equippedTheme;
  List<String> get ownedThemes => _ownedThemes;

  // Store variables directly as requested
  String get themeId => _equippedTheme.id;
  String get backgroundImage => _equippedTheme.backgroundImage;
  double get blurStrength => _equippedTheme.blurStrength;
  double get overlayOpacity => _equippedTheme.overlayOpacity;
  Color get glassTint => _equippedTheme.glassTint;
  Color get accentColor => _equippedTheme.accentColor;
  List<Color> get gradients => _equippedTheme.gradientColors;
  String get animationStyle => _equippedTheme.animationStyle;

  ThemeManager() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString('custom_background_path') ?? GlassThemeData.availableThemes.first.id;
    final savedOwnedList = prefs.getStringList('owned_themes_list') ?? [GlassThemeData.availableThemes.first.id];

    _ownedThemes = savedOwnedList;
    _equippedTheme = GlassThemeData.availableThemes.firstWhere(
      (t) => t.id == savedId || t.backgroundImage == savedId,
      orElse: () => GlassThemeData.availableThemes.first,
    );
    notifyListeners();
  }

  bool isThemePurchased(String id) {
    final theme = GlassThemeData.availableThemes.firstWhere(
      (t) => t.id == id,
      orElse: () => GlassThemeData.availableThemes.first,
    );
    return theme.price == 0 || _ownedThemes.contains(id);
  }

  bool isThemeEquipped(String id) {
    return _equippedTheme.id == id;
  }

  Future<void> equipTheme(String id) async {
    _equippedTheme = GlassThemeData.availableThemes.firstWhere(
      (t) => t.id == id,
      orElse: () => GlassThemeData.availableThemes.first,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('custom_background_path', id);
    notifyListeners();
  }

  Future<bool> purchaseTheme(String id, int userCoins, int userGems, Function(int coins, int gems) onPurchaseSuccess) async {
    final theme = GlassThemeData.availableThemes.firstWhere(
      (t) => t.id == id,
      orElse: () => GlassThemeData.availableThemes.first,
    );

    if (_ownedThemes.contains(id)) return false;

    if (theme.currency == 'coins' && userCoins >= theme.price) {
      onPurchaseSuccess(theme.price, 0);
    } else if ((theme.currency == 'gems' || theme.currency == 'diamonds') && userGems >= theme.price) {
      onPurchaseSuccess(0, theme.price);
    } else {
      return false;
    }

    _ownedThemes.add(id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('owned_themes_list', _ownedThemes);
    notifyListeners();
    return true;
  }
}
