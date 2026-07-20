import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rto_assmant/models/settings_model.dart';
import 'package:rto_assmant/services/audio_service.dart';
import 'package:rto_assmant/services/notification_service.dart';

class SettingsProvider extends ChangeNotifier {
  late SettingsModel _settings;
  bool _isLoading = true;

  SettingsProvider() {
    // Initialize with default values, then load from storage
    _settings = SettingsModel(
      darkMode: true,
      notifications: true,
      music: true,
      sound: true,
      language: 'en',
    );
    loadSettings();
  }

  bool get isLoading => _isLoading;
  bool get darkMode => _settings.darkMode;
  bool get notifications => _settings.notifications;
  bool get music => _settings.music;
  bool get sound => _settings.sound;
  String get language => _settings.language;

  SettingsModel get settings => _settings;

  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool darkMode = prefs.getBool('darkMode') ?? true;
      final bool notifications = prefs.getBool('notifications') ?? true;
      final bool music = prefs.getBool('music') ?? true;
      final bool sound = prefs.getBool('sound') ?? true;
      final String language = prefs.getString('language') ?? 'en';

      _settings = SettingsModel(
        darkMode: darkMode,
        notifications: notifications,
        music: music,
        sound: sound,
        language: language,
      );
      _isLoading = false;

      // Apply initial settings to services
      AudioService.instance.updateSettings(musicEnabled: music, soundEnabled: sound);
      NotificationService.instance.updateNotificationState(notifications);

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading settings from SharedPreferences: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> setDarkMode(bool val) async {
    try {
      _settings = _settings.copyWith(darkMode: val);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('darkMode', val);
      return true;
    } catch (e) {
      debugPrint('Error saving darkMode setting: $e');
      return false;
    }
  }

  Future<bool> setNotifications(bool val) async {
    try {
      _settings = _settings.copyWith(notifications: val);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('notifications', val);
      await NotificationService.instance.updateNotificationState(val);
      return true;
    } catch (e) {
      debugPrint('Error saving notifications setting: $e');
      return false;
    }
  }

  Future<bool> setMusic(bool val) async {
    try {
      _settings = _settings.copyWith(music: val);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('music', val);
      AudioService.instance.updateSettings(musicEnabled: val, soundEnabled: sound);
      return true;
    } catch (e) {
      debugPrint('Error saving music setting: $e');
      return false;
    }
  }

  Future<bool> setSound(bool val) async {
    try {
      _settings = _settings.copyWith(sound: val);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('sound', val);
      AudioService.instance.updateSettings(musicEnabled: music, soundEnabled: val);
      return true;
    } catch (e) {
      debugPrint('Error saving sound setting: $e');
      return false;
    }
  }

  Future<bool> setLanguage(String val) async {
    try {
      _settings = _settings.copyWith(language: val);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', val);
      return true;
    } catch (e) {
      debugPrint('Error saving language setting: $e');
      return false;
    }
  }

  /// Resets SharedPreferences (except language)
  Future<void> resetSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentLang = _settings.language;

      await prefs.remove('darkMode');
      await prefs.remove('notifications');
      await prefs.remove('music');
      await prefs.remove('sound');

      _settings = SettingsModel(
        darkMode: true,
        notifications: true,
        music: true,
        sound: true,
        language: currentLang,
      );

      // Re-apply defaults
      AudioService.instance.updateSettings(musicEnabled: true, soundEnabled: true);
      NotificationService.instance.updateNotificationState(true);

      notifyListeners();
    } catch (e) {
      debugPrint('Error resetting SharedPreferences settings: $e');
    }
  }
}
