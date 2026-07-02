import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('keeper.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const textNullable = 'TEXT';
    const boolType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE vault_items (
  id $idType,
  title $textType,
  username $textNullable,
  email $textNullable,
  password $textType,
  website $textNullable,
  notes $textNullable,
  category $textType,
  favorite $boolType,
  createdAt $textType,
  updatedAt $textType
)
''');

    await db.execute('''
CREATE TABLE categories (
  id $idType,
  name $textType,
  icon $textType,
  color $textType
)
''');

    // Insert some default categories
    await _insertDefaultCategories(db);
  }
  
  Future<void> _insertDefaultCategories(Database db) async {
    final defaultCategories = [
      {'id': '1', 'name': 'Logins', 'icon': 'login', 'color': '0xFF42A5F5'},
      {'id': '2', 'name': 'Cards', 'icon': 'credit_card', 'color': '0xFF66BB6A'},
      {'id': '3', 'name': 'Notes', 'icon': 'note', 'color': '0xFFFFA726'},
    ];
    
    for (var category in defaultCategories) {
      await db.insert('categories', category);
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
