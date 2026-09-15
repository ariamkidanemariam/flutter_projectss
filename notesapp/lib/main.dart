import 'package:flutter/material.dart';
import 'package:notesapp/view/notes_list.dart';
import 'package:notesapp/viewmodel/notes_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotesViewmodel(),
      child: MaterialApp(home: NotesListScreen()),
    );
  }
}
