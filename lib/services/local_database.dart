import 'package:practice_home/models/note.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._singleton();

  static final LocalDatabase _localDatabase = LocalDatabase._singleton();

  factory LocalDatabase() {
    return _localDatabase;
  }

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
    final path = '$databasePath/note.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute("""
     CREATE TABLE notes (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       title TEXT NOT NULL     
      )
    """);
  }

  Future<void> addNote({
    required String title,
  }) async {
    await _database!.insert('notes', {
      'title': title,
    });
  }

  Future<List<Note>> getNotes() async {
    try {
      final data = await _database!.query('notes');
      List<Note> notes = [];
      for (var row in data) {
        notes.add(Note.fromJson(row as Map<String, dynamic>));
      }
      return notes;
    } catch (e) {
      // ignore: avoid_print
      print('$e');
    }

    return [];
  }

  Future<void> deleteNote(int id) async {
    if (_database != null) {
      await _database!.delete('notes', where: 'id = $id');
    }
  }

  Future<void> editNote(
    int id,
    String title,
  ) async {
    await _database!.update(
      'notes',
      {
        'title': title,
      },
      where: 'id = $id',
    );
  }
}
