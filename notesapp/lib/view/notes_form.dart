import 'package:flutter/material.dart';
import 'package:notesapp/model/note.dart';
import 'package:notesapp/viewmodel/notes_viewmodel.dart';
import 'package:provider/provider.dart';

class NotesFormScreen extends StatefulWidget {
  final Note? note;
  const NotesFormScreen({super.key, this.note});

  @override
  createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NotesFormScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  bool get isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _save() {
    String title = _titleController.text.toString();
    String content = _contentController.text.toString();

    final vm = context.read<NotesViewmodel>();
    vm.addNote(title, content);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Mode ' : 'New Note')),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: _save,
              child: Text(isEditing ? 'Update' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
