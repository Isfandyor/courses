import 'package:practice_home/models/note.dart';
import 'package:practice_home/services/local_database.dart';

class NotesController {
  LocalDatabase localDatabase = LocalDatabase.instance;

  List<Note> _notes = [];

  Future<List<Note>> get notes async {
    await localDatabase.database;
    _notes = await localDatabase.getNotes();
    return [..._notes];
  }

  void addNotes({
    required String title,
  }) async {
    await localDatabase.addNote(
      title: title,
    );
  }

  void deleteNote(int id) async {
    await localDatabase.deleteNote(id);
  }

  void editNote(int id, String title) async {
    await localDatabase.editNote(id, title);
  }
}
