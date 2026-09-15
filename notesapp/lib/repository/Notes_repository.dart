import 'package:notesapp/data/db_helper.dart';
import 'package:notesapp/model/note.dart';

class NotesRepository {
  late DatabaseHelper _dbHelper= DatabaseHelper.instance;

  Future <int> createNote (Note note) async{
    return _dbHelper.insertNote(note.toMap());
  }

Future <List<Note>> getNotes() async{
  final noteMaps= await _dbHelper.getAllNote();
  return noteMaps.map((item)=> Note.fromMap(item)).toList();
}

}