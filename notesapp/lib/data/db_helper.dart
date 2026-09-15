import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLES notes(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT NOT NULL, 
          content TEXT NOT NULL, 
          createAt TEXT NOT NULL)''');
      },
    );
  }

  Future <int> insertNote(Map<String, dynamic> noteMap) async{
    final db = await database; 
    final map= Map<String, dynamic>.from(noteMap)..remove('id');
    return  db.insert('notes', map);
  }

  Future <List<Map<String, dynamic>>> getAllNote() async{
    final db = await database; 
    return db.query('notes', orderBy: 'createdAt DESC');
  }
}
