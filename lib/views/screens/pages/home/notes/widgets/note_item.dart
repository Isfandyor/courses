import 'package:flutter/material.dart';
import 'package:practice_home/models/note.dart';

// ignore: must_be_immutable
class NoteItem extends StatefulWidget {
  Note note;
  Function(int) delete;
  Function(Note) edit;
  NoteItem({
    super.key,
    required this.delete,
    required this.note,
    required this.edit,
  });

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        minLeadingWidth: 60,
        title: SizedBox(
          width: 100,
          child: Text(
            widget.note.title,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // subtitle: Text(
        //   widget.note.title,
        //   style: const TextStyle(fontSize: 17),
        // ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 1) {
              widget.delete(widget.note.id);
            } else if (value == 0) {
              widget.edit(widget.note);
            }
          },
          itemBuilder: (ctx) {
            return [
              const PopupMenuItem(
                value: 0,
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red[900]),
                ),
              ),
            ];
          },
        ),
      ),
    );
  }
}
