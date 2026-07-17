import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static const _databaseName = "focus_buddy.db";
  static const _databaseVersion = 3;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _onCreate(db, version);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS user_characters");
        await db.execute("DROP TABLE IF EXISTS characters");
        await db.execute('''
          CREATE TABLE characters (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            price INTEGER,
            currency TEXT DEFAULT 'coins',
            currencyType TEXT DEFAULT 'coins',
            type TEXT DEFAULT 'owl',
            rarity TEXT DEFAULT 'Common',
            backgroundPath TEXT,
            imagePath TEXT,
            unlockLevel INTEGER DEFAULT 0,
            createdAt TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE user_characters (
            characterId TEXT PRIMARY KEY,
            isPurchased INTEGER DEFAULT 0,
            isEquipped INTEGER DEFAULT 0,
            createdAt TEXT,
            FOREIGN KEY (characterId) REFERENCES characters (id) ON DELETE CASCADE
          )
        ''');
      },
      onOpen: (db) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS characters (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            price INTEGER,
            currency TEXT DEFAULT 'coins',
            currencyType TEXT DEFAULT 'coins',
            type TEXT DEFAULT 'owl',
            rarity TEXT DEFAULT 'Common',
            backgroundPath TEXT,
            imagePath TEXT,
            unlockLevel INTEGER DEFAULT 0,
            createdAt TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS user_characters (
            characterId TEXT PRIMARY KEY,
            isPurchased INTEGER DEFAULT 0,
            isEquipped INTEGER DEFAULT 0,
            createdAt TEXT,
            FOREIGN KEY (characterId) REFERENCES characters (id) ON DELETE CASCADE
          )
        ''');

        // Safely add columns if they don't exist in existing database
        try { await db.execute("ALTER TABLE characters ADD COLUMN currency TEXT DEFAULT 'coins'"); } catch (_) {}
        try { await db.execute("ALTER TABLE characters ADD COLUMN currencyType TEXT DEFAULT 'coins'"); } catch (_) {}
        try { await db.execute("ALTER TABLE characters ADD COLUMN type TEXT DEFAULT 'owl'"); } catch (_) {}
        try { await db.execute("ALTER TABLE characters ADD COLUMN backgroundPath TEXT"); } catch (_) {}
        try { await db.execute("ALTER TABLE characters ADD COLUMN description TEXT"); } catch (_) {}
        try { await db.execute("ALTER TABLE characters ADD COLUMN rarity TEXT DEFAULT 'Common'"); } catch (_) {}
        try { await db.execute("ALTER TABLE user_characters ADD COLUMN createdAt TEXT"); } catch (_) {}
        
        // Add weekly leaderboard columns to Users table dynamically
        try { await db.execute("ALTER TABLE Users ADD COLUMN weekly_score INTEGER DEFAULT 0"); } catch (_) {}
        try { await db.execute("ALTER TABLE Users ADD COLUMN last_reward_week TEXT DEFAULT ''"); } catch (_) {}
        try { await db.execute("ALTER TABLE Users ADD COLUMN diamonds INTEGER DEFAULT 0"); } catch (_) {}
        try { await db.execute("ALTER TABLE Users ADD COLUMN weekly_rank INTEGER DEFAULT 0"); } catch (_) {}
        try { await db.execute("ALTER TABLE Users ADD COLUMN reward_claimed INTEGER DEFAULT 0"); } catch (_) {}
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    // Users Table
    await db.execute('''
      CREATE TABLE Users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        avatar TEXT,
        coins INTEGER DEFAULT 0,
        gems INTEGER DEFAULT 0,
        xp INTEGER DEFAULT 0,
        currentLevel INTEGER DEFAULT 1,
        highestLevel INTEGER DEFAULT 1,
        selectedCharacter TEXT DEFAULT 'owl',
        selectedSkin TEXT DEFAULT 'default',
        dailyStreak INTEGER DEFAULT 0,
        longestStreak INTEGER DEFAULT 0,
        quizScore INTEGER DEFAULT 0,
        highestScore INTEGER DEFAULT 0,
        weekly_score INTEGER DEFAULT 0,
        last_reward_week TEXT DEFAULT '',
        diamonds INTEGER DEFAULT 0,
        weekly_rank INTEGER DEFAULT 0,
        reward_claimed INTEGER DEFAULT 0
      )
    ''');

    // QuizCategories Table
    await db.execute('''
      CREATE TABLE QuizCategories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        iconName TEXT,
        colorHex TEXT
      )
    ''');

    // QuizSets Table
    await db.execute('''
      CREATE TABLE QuizSets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryId INTEGER,
        title TEXT,
        difficulty TEXT,
        isUnlocked INTEGER DEFAULT 1,
        FOREIGN KEY (categoryId) REFERENCES QuizCategories (id) ON DELETE CASCADE
      )
    ''');

    // Questions Table
    await db.execute('''
      CREATE TABLE Questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryId INTEGER,
        quizId INTEGER,
        question TEXT NOT NULL,
        optionA TEXT NOT NULL,
        optionB TEXT NOT NULL,
        optionC TEXT NOT NULL,
        optionD TEXT NOT NULL,
        correctAnswer TEXT NOT NULL,
        explanation TEXT,
        difficulty TEXT,
        rewardCoins INTEGER DEFAULT 20,
        rewardXP INTEGER DEFAULT 10,
        FOREIGN KEY (categoryId) REFERENCES QuizCategories (id) ON DELETE CASCADE,
        FOREIGN KEY (quizId) REFERENCES QuizSets (id) ON DELETE CASCADE
      )
    ''');

    // UserAnswers Table
    await db.execute('''
      CREATE TABLE UserAnswers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        questionId INTEGER,
        selectedAnswer TEXT,
        isCorrect INTEGER,
        timestamp TEXT,
        FOREIGN KEY (questionId) REFERENCES Questions (id) ON DELETE CASCADE
      )
    ''');

    // QuizHistory Table
    await db.execute('''
      CREATE TABLE QuizHistory (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quizId INTEGER,
        score INTEGER,
        correctAnswers INTEGER,
        wrongAnswers INTEGER,
        accuracy REAL,
        timestamp TEXT,
        FOREIGN KEY (quizId) REFERENCES QuizSets (id) ON DELETE CASCADE
      )
    ''');

    // Shop/Inventory related tables
    await db.execute('''
      CREATE TABLE CharacterSkins (
        id TEXT PRIMARY KEY,
        name TEXT,
        costCoins INTEGER,
        costGems INTEGER,
        isUnlocked INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE characters (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        price INTEGER,
        currency TEXT DEFAULT 'coins',
        currencyType TEXT DEFAULT 'coins',
        type TEXT DEFAULT 'owl',
        rarity TEXT DEFAULT 'Common',
        backgroundPath TEXT,
        imagePath TEXT,
        unlockLevel INTEGER DEFAULT 0,
        createdAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE user_characters (
        characterId TEXT PRIMARY KEY,
        isPurchased INTEGER DEFAULT 0,
        isEquipped INTEGER DEFAULT 0,
        createdAt TEXT,
        FOREIGN KEY (characterId) REFERENCES characters (id) ON DELETE CASCADE
      )
    ''');

    // Settings
    await db.execute('''
      CREATE TABLE Settings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        darkMode INTEGER DEFAULT 1,
        notifications INTEGER DEFAULT 1,
        music INTEGER DEFAULT 1,
        sound INTEGER DEFAULT 1,
        language TEXT DEFAULT 'en'
      )
    ''');

    // Insert default user
    await db.execute('''
      INSERT INTO Users (name, xp, coins, gems, currentLevel) 
      VALUES ('Focus Warrior', 0, 100, 10, 1)
    ''');

    // Insert default settings
    await db.execute('''
      INSERT INTO Settings (darkMode, notifications, music, sound, language) 
      VALUES (1, 1, 1, 1, 'en')
    ''');
  }
}
