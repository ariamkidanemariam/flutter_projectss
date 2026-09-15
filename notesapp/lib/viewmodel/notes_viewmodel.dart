import 'package:flutter/material.dart';
import 'package:notesapp/model/note.dart';
import 'package:notesapp/repository/Notes_repository.dart';

class NotesViewmodel extends ChangeNotifier {
  late NotesRepository _notesRepository;

  NotesViewmodel({NotesRepository? repo}) {
    _notesRepository = repo ?? NotesRepository();
  }

  List<Note> notesList = [];
  String? errorMessage;
  bool isLoading = false;

  Future<void> loadNotes() async {
    isLoading = true;
    try {
      notesList = await _notesRepository.getNotes();
    } catch (e) {
      errorMessage = 'Failed to get notes';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNote(String title, String content) async {
    try {
      final note = Note(title: title, content: content);
      await _notesRepository.createNote(note);
      await loadNotes();
    } catch (e) {
      errorMessage = 'Failed to create note $e';
      notifyListeners();
    }
  }
}
