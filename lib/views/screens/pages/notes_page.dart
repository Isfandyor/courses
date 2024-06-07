import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_home/controllers/notes_controller.dart';
import 'package:practice_home/models/note.dart';
import 'package:practice_home/views/screens/pages/home/notes/widgets/add_dialog.dart';
import 'package:practice_home/views/screens/pages/home/notes/widgets/note_item.dart';
import 'package:practice_home/views/screens/pages/home/notes/widgets/edit_dialog.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final notesController = NotesController();
  TextEditingController textEditingController = TextEditingController();
  List<Note> notes = [];
  List<Note> filteredNotes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    notes = await notesController.notes;
    setState(() {
      filteredNotes = notes;
    });
  }

  void deleteNote(int id) {
    notesController.deleteNote(id);
    _loadNotes();
  }

  void editNote(Note title) async {
    Map<String, dynamic> data = await showDialog(
      context: context,
      builder: (ctx) => EditDialog(
        note: title,
      ),
    );
    notesController.editNote(
      title.id,
      data['title'],
    );
    _loadNotes();
  }

  void _filterNotes(String query) {
    final filtered = notes.where((note) {
      final fullName = note.title.toLowerCase();
      final searchQuery = query.toLowerCase();
      return fullName.contains(searchQuery);
    }).toList();
    if (query.trim().isNotEmpty) {
      setState(() {
        filteredNotes = filtered;
      });
    } else {
      _loadNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  _filterNotes(value);
                },
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  fillColor: Colors.grey[300],
                  filled: true,
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: Colors.grey[700],
                    size: 25,
                  ),
                  hintText: 'Search notes',
                  suffix: InkWell(
                    onTap: () {
                      textEditingController.clear();
                      _filterNotes('');
                    },
                    child: Ink(
                      child: Icon(
                        CupertinoIcons.clear_circled_solid,
                        color: Colors.grey[400],
                        size: 25,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.grey[200],
        title: const Text(
          "Notes",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Map<String, dynamic>? data = await showDialog(
                context: context,
                builder: (ctx) => const AddAlertDialog(),
              );
              if (data != null) {
                notesController.addNotes(
                  title: data['title'],
                );
                _loadNotes();
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<List<Note>>(
        future: notesController.notes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notes found'));
          } else {
            return ListView.builder(
              itemCount: filteredNotes.length,
              itemBuilder: (ctx, index) {
                return NoteItem(
                    note: filteredNotes[index],
                    delete: deleteNote,
                    edit: editNote);
              },
            );
          }
        },
      ),
    );
  }
}
