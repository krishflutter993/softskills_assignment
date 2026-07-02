import 'package:sqflite/sqflite.dart';
import '../models/vault_item.dart';
import '../models/category.dart';
import 'database_helper.dart';

class DatabaseService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // --- Vault Items CRUD ---

  Future<VaultItem> createItem(VaultItem item) async {
    final db = await _dbHelper.database;
    await db.insert(
      'vault_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return item;
  }

  Future<VaultItem?> readItem(String id) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'vault_items',
      columns: ['id', 'title', 'username', 'email', 'password', 'website', 'notes', 'category', 'favorite', 'createdAt', 'updatedAt'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return VaultItem.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<VaultItem>> readAllItems({String? category, bool? favorite, String? query, String? sortBy}) async {
    final db = await _dbHelper.database;
    
    String whereClause = '';
    List<dynamic> whereArgs = [];
    
    if (category != null && category.isNotEmpty) {
      whereClause += 'category = ?';
      whereArgs.add(category);
    }
    
    if (favorite != null) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += 'favorite = ?';
      whereArgs.add(favorite ? 1 : 0);
    }
    
    if (query != null && query.isNotEmpty) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += '(title LIKE ? OR username LIKE ? OR website LIKE ?)';
      whereArgs.addAll(['%$query%', '%$query%', '%$query%']);
    }
    
    String orderBy = 'createdAt DESC';
    if (sortBy == 'title') {
      orderBy = 'title ASC';
    } else if (sortBy == 'updatedAt') {
      orderBy = 'updatedAt DESC';
    }

    final result = await db.query(
      'vault_items',
      where: whereClause.isEmpty ? null : whereClause,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      orderBy: orderBy,
    );
    
    return result.map((map) => VaultItem.fromMap(map)).toList();
  }

  Future<int> updateItem(VaultItem item) async {
    final db = await _dbHelper.database;
    return db.update(
      'vault_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteItem(String id) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'vault_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  Future<int> toggleFavorite(String id, bool isFavorite) async {
    final db = await _dbHelper.database;
    return db.update(
      'vault_items',
      {'favorite': isFavorite ? 1 : 0, 'updatedAt': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Categories CRUD ---

  Future<ItemCategory> createCategory(ItemCategory category) async {
    final db = await _dbHelper.database;
    await db.insert(
      'categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return category;
  }

  Future<List<ItemCategory>> readAllCategories() async {
    final db = await _dbHelper.database;
    final result = await db.query('categories', orderBy: 'name ASC');
    return result.map((map) => ItemCategory.fromMap(map)).toList();
  }
}
