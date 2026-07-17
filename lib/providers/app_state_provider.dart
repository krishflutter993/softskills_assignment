import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rto_assmant/models/quiz_result_model.dart';
import 'package:rto_assmant/database/database_helper.dart';
import 'package:rto_assmant/repositories/character_repository.dart';

class AppStateProvider extends ChangeNotifier {
  int _coins = 0;
  int _gems = 0;
  int _xp = 0;
  int _level = 1;
  String _rankTitle = "Beginner";
  int _currentStreak = 0;
  DateTime? _lastLoginDate;
  bool _isDailyBonusClaimed = false;
  
  String _equippedOwlSkin = "forest_owl";
  List<String> _ownedOwlSkins = ["forest_owl"];
  List<QuizResult> _quizHistory = [];
  List<String> _unlockedCategories = ["Science", "Math", "History", "Tech", "Art", "Music"];
  bool _isFirstLaunch = true;

  int get coins => _coins;
  int get gems => _gems;
  int get xp => _xp;
  int get level => _level;
  String get rankTitle => _rankTitle;
  int get currentStreak => _currentStreak;
  bool get isDailyBonusClaimed => _isDailyBonusClaimed;
  String get equippedOwlSkin => _equippedOwlSkin;
  String get equippedSkinImagePath => equippedCharacterImage;
  List<String> get ownedOwlSkins => _ownedOwlSkins;
  List<QuizResult> get quizHistory => _quizHistory;
  List<String> get unlockedCategories => _unlockedCategories;
  bool get isFirstLaunch => _isFirstLaunch;

  Map<String, dynamic>? _equippedCharacter;
  Map<String, dynamic>? get equippedCharacter => _equippedCharacter;
  String get equippedCharacterImage => _equippedCharacter?['imagePath'] ?? 'assets/images/owl.png';
  String get equippedCharacterBackground {
    final bg = _equippedCharacter?['backgroundPath'] as String?;
    return (bg != null && bg.isNotEmpty) ? bg : 'assets/Theme/screen.png';
  }
  String _customBackground = 'assets/Theme/screen.png';
  String get customBackground => _customBackground;
  String get equippedBackground => _customBackground;
  List<String> _ownedThemes = ['assets/Theme/screen.png'];
  List<String> get ownedThemes => _ownedThemes;

  List<Map<String, dynamic>> _characters = [];
  List<Map<String, dynamic>> get characters => _characters;

  Future<void> syncWithCharacterService() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> skins = await db.query('user_characters', where: 'isPurchased = ?', whereArgs: [1]);
    _ownedOwlSkins = skins.map((s) => s['characterId'] as String).toList();
    if (!_ownedOwlSkins.contains('forest_owl')) _ownedOwlSkins.add('forest_owl');

    final repo = CharacterRepository(dbHelper: DatabaseHelper.instance);
    _characters = await repo.getAllCharacters();

    _equippedCharacter = await repo.getEquippedCharacter();
    if (_equippedCharacter != null) {
      _equippedOwlSkin = _equippedCharacter!['id'] as String;
    } else {
      _equippedOwlSkin = 'forest_owl';
      final List<Map<String, dynamic>> chars = await db.query('characters', where: 'id = ?', whereArgs: ['forest_owl']);
      if (chars.isNotEmpty) {
        _equippedCharacter = chars.first;
      }
    }
    notifyListeners();
  }

  Future<void> loadState() async {
    final db = await DatabaseHelper.instance.database;
    
    // Ensure default characters are populated
    final repo = CharacterRepository(dbHelper: DatabaseHelper.instance);
    await repo.initDefaultCharacters();

    final List<Map<String, dynamic>> maps = await db.query('Users', limit: 1);
    
    if (maps.isNotEmpty) {
      final user = maps.first;
      _coins = user['coins'] as int? ?? 0;
      _gems = user['gems'] as int? ?? 0;
      _xp = user['xp'] as int? ?? 0;
      _level = user['currentLevel'] as int? ?? 1;
      _currentStreak = user['dailyStreak'] as int? ?? 0;
      _equippedOwlSkin = user['selectedSkin'] as String? ?? 'default';
      _isFirstLaunch = false; // We have a user in DB, so not first launch
    }

    _updateRankTitle();
    await syncWithCharacterService();
    
    final List<Map<String, dynamic>> history = await db.query('QuizHistory', orderBy: 'timestamp DESC');
    _quizHistory = history.map((h) {
      return QuizResult(
        category: 'Mixed', // SQLite doesn't store category in history easily right now, mock it
        score: h['score'] as int? ?? 0,
        date: h['timestamp'] != null ? DateTime.parse(h['timestamp'] as String) : DateTime.now(),
        correctCount: h['correctAnswers'] as int? ?? 0,
        totalQuestions: ((h['correctAnswers'] as int? ?? 0) + (h['wrongAnswers'] as int? ?? 0)),
      );
    }).toList();

    final prefs = await SharedPreferences.getInstance();
    final lastClaimedStr = prefs.getString('last_daily_bonus_claimed_date');
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);
    _isDailyBonusClaimed = (lastClaimedStr == todayStr);
    final savedBg = prefs.getString('custom_background_path') ?? 'assets/Theme/screen.png';
    _customBackground = savedBg.replaceAll('assets/theme/', 'assets/Theme/');
    final savedThemes = prefs.getStringList('owned_themes_list') ?? ['assets/Theme/screen.png'];
    _ownedThemes = savedThemes.map((t) => t.replaceAll('assets/theme/', 'assets/Theme/')).toList();

    _checkDailyStreak();
    notifyListeners();
  }

  Future<void> saveState() async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'Users',
      {
        'coins': _coins,
        'gems': _gems,
        'xp': _xp,
        'currentLevel': _level,
        'dailyStreak': _currentStreak,
        'selectedSkin': _equippedOwlSkin,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  void completeFirstLaunch() {
    _isFirstLaunch = false;
    saveState();
    notifyListeners();
  }

  void _checkDailyStreak() {
    _currentStreak++;
    saveState();
  }

  void addCoins(int amount) {
    _coins += amount;
    saveState();
    notifyListeners();
  }

  void addGems(int amount) {
    _gems += amount;
    saveState();
    notifyListeners();
  }

  void addXp(int amount) {
    _xp += amount;
    _checkLevelUp();
    saveState();
    notifyListeners();
  }

  void _checkLevelUp() {
    int requiredXp = _level * 100;
    while (_xp >= requiredXp) {
      _xp -= requiredXp;
      _level++;
      _updateRankTitle();
      requiredXp = _level * 100;
    }
  }

  void _updateRankTitle() {
    if (_level < 5) _rankTitle = "Beginner";
    else if (_level < 10) _rankTitle = "Focus Warrior";
    else if (_level < 20) _rankTitle = "Master Owl";
    else _rankTitle = "Legend";
  }

  Future<bool> purchaseSkin(String skinId, int price, String currency) async {
    if (_ownedOwlSkins.contains(skinId)) return false;

    if (currency == 'coins' && _coins >= price) {
      _coins -= price;
      _ownedOwlSkins.add(skinId);
    } else if ((currency == 'gems' || currency == 'diamonds') && _gems >= price) {
      _gems -= price;
      _ownedOwlSkins.add(skinId);
    } else {
      return false;
    }

    final db = await DatabaseHelper.instance.database;
    await db.insert('CharacterSkins', {
      'id': skinId,
      'isUnlocked': 1,
    }, conflictAlgorithm: ConflictAlgorithm.replace);

    final repo = CharacterRepository(dbHelper: DatabaseHelper.instance);
    await repo.purchaseCharacter(skinId);

    await saveState();
    await syncWithCharacterService();
    return true;
  }

  void equipSkin(String skinId) async {
    if (_ownedOwlSkins.contains(skinId)) {
      _equippedOwlSkin = skinId;
      final repo = CharacterRepository(dbHelper: DatabaseHelper.instance);
      await repo.equipCharacter(skinId);
      await saveState();
      await syncWithCharacterService();
    }
  }

  Future<void> resetProgress() async {
    final repo = CharacterRepository(dbHelper: DatabaseHelper.instance);
    await repo.resetProgress();
    _coins = 100;
    _gems = 10;
    _xp = 0;
    _level = 1;
    _equippedOwlSkin = 'forest_owl';
    _updateRankTitle();
    await saveState();
    await syncWithCharacterService();
  }

  Future<void> recordQuizResult(QuizResult result) async {
    _quizHistory.add(result);
    int earnedCoins = result.correctCount * 10;
    int earnedXp = result.correctCount * 15 + (result.correctCount == result.totalQuestions ? 50 : 0);
    
    addCoins(earnedCoins);
    addXp(earnedXp);

    final db = await DatabaseHelper.instance.database;
    await db.insert('QuizHistory', {
      'quizId': 1, // Mock quiz id
      'score': result.score,
      'correctAnswers': result.correctCount,
      'wrongAnswers': result.totalQuestions - result.correctCount,
      'accuracy': result.correctCount / result.totalQuestions,
      'timestamp': result.date.toIso8601String(),
    });
  }

  Future<bool> claimDailyBonus() async {
    if (_isDailyBonusClaimed) return false;
    _isDailyBonusClaimed = true;
    _gems += 30; // 30 gems/diamonds
    await saveState();

    final prefs = await SharedPreferences.getInstance();
    final todayStr = DateTime.now().toIso8601String().substring(0, 10);
    await prefs.setString('last_daily_bonus_claimed_date', todayStr);
    
    notifyListeners();
    return true;
  }

  Future<void> equipBackground(String path) async {
    _customBackground = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('custom_background_path', path);
    notifyListeners();
  }

  Future<bool> purchaseTheme(String themePath, int price, String currency) async {
    if (_ownedThemes.contains(themePath)) return false;

    if (currency == 'coins' && _coins >= price) {
      _coins -= price;
      _ownedThemes.add(themePath);
    } else if ((currency == 'gems' || currency == 'diamonds') && _gems >= price) {
      _gems -= price;
      _ownedThemes.add(themePath);
    } else {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('owned_themes_list', _ownedThemes);
    await saveState();
    notifyListeners();
    return true;
  }

  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  void deductCoins(int amount) {
    _coins -= amount;
    saveState();
    notifyListeners();
  }

  void deductGems(int amount) {
    _gems -= amount;
    saveState();
    notifyListeners();
  }
}
