import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/library_item.dart';

class LibraryDatabase {
  static final LibraryDatabase instance = LibraryDatabase._init();
  static Database? _database;

  LibraryDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('library.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE libraryItems ( 
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  name TEXT NOT NULL, 
  date TEXT NOT NULL,
  description TEXT NOT NULL,
  imageUrl TEXT NOT NULL
  )
''');
  }

  Future<LibraryItem> create(LibraryItem item) async {
    final db = await instance.database;
    final id = await db.insert('shoppingItems', item.toMap());
    return item.copyWith(id: id);
  }

  Future<LibraryItem?> readItem(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'libraryItems',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return LibraryItem.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<LibraryItem>> readAllItems() async {
    final db = await instance.database;
    final orderBy = 'name ASC';
    final result = await db.query('libraryItems', orderBy: orderBy);
    return result.map((e) => LibraryItem.fromMap(e)).toList();
  }

  Future<int> update(LibraryItem item) async {
    final db = await instance.database;
    return db.update(
      'libraryItems',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      'libraryItems',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
