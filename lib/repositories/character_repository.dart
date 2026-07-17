import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert' show json;
import 'package:rto_assmant/database/database_helper.dart';

class CharacterRepository {
  final DatabaseHelper _dbHelper;

  CharacterRepository({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  Future<void> initDefaultCharacters() async {
    final db = await _dbHelper.database;
    final now = DateTime.now().toIso8601String();

    // Clear old character definitions to prevent duplicate assets/names
    await db.delete('characters');

    final defaultCharacters = [
      // Coin Characters
      {
        'id': 'forest_owl',
        'name': 'Forest Owl',
        'description': 'A gentle guardian of the woods.',
        'price': 300,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Common',
        'imagePath': 'assets/images/coin_5.png',

        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'student_owl',
        'name': 'Student Owl',
        'description': 'Always eager to learn new things.',
        'price': 500,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Common',
        'imagePath': 'assets/images/coin_1.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'chef_owl',
        'name': 'Chef Owl',
        'description': 'Cooks up delicious recipes for success.',
        'price': 700,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Common',
        'imagePath': 'assets/images/coin_2.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'police_owl',
        'name': 'Police Owl',
        'description': 'Maintains focus and order in the quiz realm.',
        'price': 900,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Rare',
        'imagePath': 'assets/images/coin_3.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'doctor_owl',
        'name': 'Doctor Owl',
        'description': 'Prescribes healthy habits and study schedules.',
        'price': 1200,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Rare',
        'imagePath': 'assets/images/coin_4.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'pirate_owl',
        'name': 'Pirate Owl',
        'description': 'Sails the high seas in search of knowledge.',
        'price': 1500,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Rare',
        'imagePath': 'assets/images/coin_6.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'knight_owl',
        'name': 'Knight Owl',
        'description': 'A brave protector of truth and wisdom.',
        'price': 1800,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Epic',
        'imagePath': 'assets/images/coin_7.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'wizard_apprentice',
        'name': 'Wizard Apprentice',
        'description': 'Learning the magical secrets of focus.',
        'price': 2200,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Epic',
        'imagePath': 'assets/images/coin_8.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'robot_owl',
        'name': 'Robot Owl',
        'description': 'Programmed for maximum logical efficiency.',
        'price': 2800,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Epic',
        'imagePath': 'assets/images/coin_9.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'cyber',
        'name': 'Cyber Owl',
        'description': 'Navigates the digital grid with precision.',
        'price': 3500,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Legendary',
        'imagePath': 'assets/images/coin_10.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'crystal',
        'name': 'Crystal Owl',
        'description': 'Gleaming with ancient crystal energy.',
        'price': 4500,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Legendary',
        'imagePath': 'assets/images/coin_11.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
      {
        'id': 'golden',
        'name': 'Golden Owl',
        'description': 'Meticulously crafted from solid gold.',
        'price': 6000,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Legendary',
        'imagePath': 'assets/images/coin_12.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      // Gem Characters
      {
        'id': 'crystal_owl',
        'name': 'Crystal Owl',
        'description': 'A magical owl crafted from glowing crystals.',
        'price': 10,
        'currency': 'gems',
        'currencyType': 'gems',
        'type': 'owl',
        'rarity': 'Rare',
        'imagePath': 'assets/images/crystal_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'cyber_owl',
        'name': 'Cyber Owl',
        'description': 'A futuristic cyber companion with neon power.',
        'price': 700,
        'currency': 'gems',
        'currencyType': 'gems',
        'type': 'owl',
        'rarity': 'Epic',
        'imagePath': 'assets/images/cyber_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'dragon_owl',
        'name': 'Dragon Owl',
        'description': 'An ancient owl empowered by dragon fire.',
        'price': 900,
        'currency': 'gems',
        'currencyType': 'gems',
        'type': 'owl',
        'rarity': 'Legendary',
        'imagePath': 'assets/images/dragon_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'galaxy_owl',
        'name': 'Galaxy Owl',
        'description': 'A cosmic guardian born among the stars.',
        'price': 1200,
        'currency': 'gems',
        'currencyType': 'gems',
        'type': 'owl',
        'rarity': 'Legendary',
        'imagePath': 'assets/images/galaxy_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'ghost_owl',
        'name': 'Ghost Owl',
        'description': 'A mysterious spirit owl from the shadows.',
        'price': 400,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Common',
        'imagePath': 'assets/images/ghost_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'golden_owl',
        'name': 'Golden Owl',
        'description': 'A majestic owl forged from pure gold.',
        'price': 5000,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Legendary',
        'imagePath': 'assets/images/golden_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'ice_owl',
        'name': 'Ice Owl',
        'description': 'A frozen guardian from the icy mountains.',
        'price': 600,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Rare',
        'imagePath': 'assets/images/ice_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'mystic_owl',
        'name': 'Mystic Owl',
        'description': 'An enchanted owl filled with magical wisdom.',
        'price': 1800,
        'currency': 'gems',
        'currencyType': 'gems',
        'type': 'owl',
        'rarity': 'Mythic',
        'imagePath': 'assets/images/mystic_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'phoenix_owl',
        'name': 'Phoenix Owl',
        'description': 'A legendary owl reborn from eternal flames.',
        'price': 1500,
        'currency': 'gems',
        'currencyType': 'gems',
        'type': 'owl',
        'rarity': 'Mythic',
        'imagePath': 'assets/images/phoenix_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'rainbow_owl',
        'name': 'Rainbow Owl',
        'description': 'A colorful owl spreading joy and light.',
        'price': 900,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Epic',
        'imagePath': 'assets/images/rainbow_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'royal_owl',
        'name': 'Royal Owl',
        'description': 'The royal guardian of the Lumina Kingdom.',
        'price': 2500,
        'currency': 'gems',
        'currencyType': 'gems',
        'type': 'owl',
        'rarity': 'Legendary',
        'imagePath': 'assets/images/royal_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'samurai_owl',
        'name': 'Samurai Owl',
        'description': 'A fearless warrior with unmatched honor.',
        'price': 2500,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Epic',
        'imagePath': 'assets/images/samurai_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'shadow_owl',
        'name': 'Shadow Owl',
        'description': 'A stealthy owl that rules the darkness.',
        'price': 3500,
        'currency': 'gems',
        'currencyType': 'gems',
        'type': 'owl',
        'rarity': 'Legendary',
        'imagePath': 'assets/images/shadow_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'thunder_owl',
        'name': 'Thunder Owl',
        'description': 'A powerful owl charged with lightning energy.',
        'price': 4000,
        'currency': 'coins',
        'currencyType': 'coins',
        'type': 'owl',
        'rarity': 'Legendary',
        'imagePath': 'assets/images/thunder_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },

      {
        'id': 'cosmic_emperor_owl',
        'name': 'Cosmic Emperor Owl',
        'description': 'The ultimate emperor of the Lumina universe.',
        'price': 5000,
        'currency': 'gems',
        'currencyType': 'gems',
        'type': 'owl',
        'rarity': 'Mythic',
        'imagePath': 'assets/images/cosmic_emperor_owl.png',
        'unlockLevel': 0,
        'createdAt': now,
      },
    ];

    for (var char in defaultCharacters) {
      final charCopy = Map<String, dynamic>.from(char);
      charCopy['backgroundPath'] = charCopy['id'] as String;
      await db.insert(
        'characters',
        charCopy,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // Migrate old equipped character IDs
    try {
      await db.rawUpdate('''
        UPDATE user_characters 
        SET characterId = 'forest_owl' 
        WHERE characterId = 'coin_5'
      ''');
      await db.rawDelete('''
        DELETE FROM user_characters 
        WHERE characterId NOT IN (SELECT id FROM characters)
      ''');
    } catch (_) {}

    // Default user character (forest_owl is purchased and equipped)
    final existingUserChar = await db.query(
      'user_characters',
      where: 'characterId = ?',
      whereArgs: ['forest_owl'],
    );

    if (existingUserChar.isEmpty) {
      await db.insert('user_characters', {
        'characterId': 'forest_owl',
        'isPurchased': 1,
        'isEquipped': 1,
        'createdAt': now,
      }); 
    }

    // Migrate existing characters with empty, null or outdated backgroundPath
    try {
      final List<Map<String, dynamic>> existingRecords = await db.query(
        'characters',
      );
      for (var record in existingRecords) {
        final String recordId = record['id'] as String;
        final String? bgPath = record['backgroundPath'] as String?;
        if (bgPath == null ||
            bgPath.isEmpty ||
            bgPath == 'null' ||
            bgPath.contains('assets/backgrounds/')) {
          await db.update(
            'characters',
            {'backgroundPath': (recordId)},
            where: 'id = ?',
            whereArgs: [recordId],
          );
        }
      }
    } catch (_) {}

    // Dynamic scanning of assets
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final characterImages = manifestMap.keys
          .where(
            (key) =>
                key.startsWith('assets/images/') &&
                (key.endsWith('.png') ||
                    key.endsWith('.jpg') ||
                    key.endsWith('.webp')),
          )
          .toList();

      for (var path in characterImages) {
        final fileName = path.split('/').last;
        final dotIndex = fileName.lastIndexOf('.');
        final id = dotIndex != -1 ? fileName.substring(0, dotIndex) : fileName;

        // Skip helper/system/non-character images
        if (id == 'avatar' || id == 'onboarding' || id == 'hero_pack') {
          continue;
        }

        // Check if character already exists in db by ID or imagePath
        final existing = await db.query(
          'characters',
          where: 'id = ? OR imagePath = ?',
          whereArgs: [id, path],
        );
        if (existing.isEmpty) {
          final isCoin = id.contains('coin');
          final String name = id
              .split('_')
              .map((word) {
                if (word.isEmpty) return '';
                return word[0].toUpperCase() + word.substring(1);
              })
              .join(' ');

          await db.insert('characters', {
            'id': id,
            'name': name,
            'description':
                'A newly discovered ${isCoin ? "coin" : "gem"} companion.',
            'price': isCoin ? 500 : 250,
            'currency': isCoin ? 'coins' : 'gems',
            'currencyType': isCoin ? 'coins' : 'gems',
            'type': 'owl',
            'rarity': 'Rare',
            'imagePath': path,
            'backgroundPath': (id),
            'unlockLevel': 0,
            'createdAt': now,
          });
        } else {
          // If it exists but backgroundPath is null, empty or outdated, update it
          final record = existing.first;
          final String? bgPath = record['backgroundPath'] as String?;
          if (bgPath == null ||
              bgPath.isEmpty ||
              bgPath == 'null' ||
              bgPath.contains('assets/backgrounds/')) {
            await db.update(
              'characters',
              {'backgroundPath': (id)},
              where: 'id = ?',
              whereArgs: [id],
            );
          }
        }
      }
    } catch (e) {
      print("Error scanning assets at runtime: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getAllCharacters() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT 
        c.id, 
        c.name, 
        c.description,
        c.price, 
        c.currency,
        c.currencyType,
        c.type,
        c.rarity,
        c.imagePath, 
        c.backgroundPath,
        c.unlockLevel, 
        c.createdAt,
        COALESCE(uc.isPurchased, 0) as isPurchased,
        COALESCE(uc.isEquipped, 0) as isEquipped
      FROM characters c
      LEFT JOIN user_characters uc ON c.id = uc.characterId
    ''');
    return results;
  }

  Future<void> purchaseCharacter(String characterId) async {
    final db = await _dbHelper.database;
    final now = DateTime.now().toIso8601String();
    await db.insert('user_characters', {
      'characterId': characterId,
      'isPurchased': 1,
      'isEquipped': 0,
      'createdAt': now,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> equipCharacter(String characterId) async {
    final db = await _dbHelper.database;
    await db.transaction((txn) async {
      await txn.update('user_characters', {'isEquipped': 0});
      await txn.update(
        'user_characters',
        {'isEquipped': 1},
        where: 'characterId = ?',
        whereArgs: [characterId],
      );
    });
  }

  Future<Map<String, dynamic>?> getEquippedCharacter() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT 
        c.id, 
        c.name, 
        c.description,
        c.price, 
        c.currency,
        c.currencyType,
        c.type,
        c.rarity,
        c.imagePath, 
        c.backgroundPath,
        c.unlockLevel, 
        c.createdAt
      FROM characters c
      INNER JOIN user_characters uc ON c.id = uc.characterId
      WHERE uc.isEquipped = 1
      LIMIT 1
    ''');
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  Future<void> resetProgress() async {
    final db = await _dbHelper.database;
    await db.delete('user_characters');
    await db.insert('user_characters', {
      'characterId': 'forest_owl',
      'isPurchased': 1,
      'isEquipped': 1,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }
}
