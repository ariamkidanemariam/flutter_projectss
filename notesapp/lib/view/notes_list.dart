import 'package:flutter/material.dart';
import 'package:notesapp/model/note.dart';
import 'package:notesapp/view/notes_form.dart';
import 'package:notesapp/viewmodel/notes_viewmodel.dart';
import 'package:provider/provider.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NotesListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesViewmodel>().loadNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NotesViewmodel>();
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: vm.isLoading
          ? Center(child: CircularProgressIndicator())
          : vm.notesList.isEmpty
          ? Center(child: Text('No notes added yet!'))
          : ListView.builder(
              itemCount: vm.notesList.length,
              itemBuilder: (context, index) {
                final note = vm.notesList[index];
                return NoteCard(note: note);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NotesFormScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final Note note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(note.title), Text(note.content)],
        ),
      ),
    );
  }
}
