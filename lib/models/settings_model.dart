class SettingsModel {
  final bool darkMode;
  final bool notifications;
  final bool music;
  final bool sound;
  final String language;

  SettingsModel({
    required this.darkMode,
    required this.notifications,
    required this.music,
    required this.sound,
    required this.language,
  });

  SettingsModel copyWith({
    bool? darkMode,
    bool? notifications,
    bool? music,
    bool? sound,
    String? language,
  }) {
    return SettingsModel(
      darkMode: darkMode ?? this.darkMode,
      notifications: notifications ?? this.notifications,
      music: music ?? this.music,
      sound: sound ?? this.sound,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'darkMode': darkMode ? 1 : 0,
      'notifications': notifications ? 1 : 0,
      'music': music ? 1 : 0,
      'sound': sound ? 1 : 0,
      'language': language,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      darkMode: (map['darkMode'] as int? ?? 1) == 1,
      notifications: (map['notifications'] as int? ?? 1) == 1,
      music: (map['music'] as int? ?? 1) == 1,
      sound: (map['sound'] as int? ?? 1) == 1,
      language: map['language'] as String? ?? 'en',
    );
  }
}
