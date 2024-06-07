import 'package:flutter/material.dart';
import 'package:practice_home/models/note.dart';

// ignore: must_be_immutable
class EditDialog extends StatefulWidget {
  Note note;
  EditDialog({super.key, required this.note});

  @override
  State<EditDialog> createState() => _AddAlertDialogState();
}

class _AddAlertDialogState extends State<EditDialog> {
  final formKey = GlobalKey<FormState>();

  String? title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: Text(
          "Edit Note",
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              initialValue: widget.note.title,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter note';
                }
                return null;
              },
              onSaved: (newValue) {
                title = newValue;
              },
              decoration: const InputDecoration(
                label: Text(
                  "Note",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              Navigator.pop(
                context,
                {
                  "title": title,
                },
              );
            }
          },
          child: const Text(
            "Save",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
