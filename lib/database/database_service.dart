import 'package:sqflite/sqflite.dart';
import 'package:rto_assmant/models/user_model.dart';
import 'package:rto_assmant/models/question_model.dart';
import 'database_helper.dart';

class DatabaseService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // --- USER OPERATIONS ---
  
  Future<int> insertUser(UserModel user) async {
    final db = await _dbHelper.database;
    return await db.insert(
      'Users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel?> getUser(int id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }
  
  Future<UserModel?> getFirstUser() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Users',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateUser(UserModel user) async {
    final db = await _dbHelper.database;
    return await db.update(
      'Users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // --- QUESTION OPERATIONS ---

  Future<void> insertQuestions(List<QuestionModel> questions) async {
    final db = await _dbHelper.database;
    Batch batch = db.batch();
    for (var q in questions) {
      batch.insert(
        'Questions',
        q.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<int> getQuestionsCount() async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM Questions');
    int count = Sqflite.firstIntValue(result) ?? 0;
    return count;
  }

  Future<List<QuestionModel>> getQuestionsByCategory(int categoryId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Questions',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );

    return List.generate(maps.length, (i) {
      return QuestionModel.fromMap(maps[i]);
    });
  }
}
