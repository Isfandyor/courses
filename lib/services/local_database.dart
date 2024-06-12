import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:practice_home/models/note.dart';

class LocalDatabase {
  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'note.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute("""
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL
      )
    """);
  }

  Future<void> addNote({
    required String title,
  }) async {
    final db = await database;
    await db.insert('notes', {
      'title': title,
    });
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final data = await db.query('notes');
    return data.map((row) => Note.fromJson(row)).toList();
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> editNote(int id, String title) async {
    final db = await database;
    await db.update(
      'notes',
      {'title': title},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
