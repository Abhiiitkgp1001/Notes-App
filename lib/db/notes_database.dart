import 'package:notesapp/classes/note_class.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  NotesDatabase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    String dbPath = await getDatabasesPath();
    String path = dbPath + 'noteapp.db';
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
      String intType = 'INTEGER';
      String textType = 'TEXT NOT NULL';
      await db.execute(
          'CREATE TABLE NoteTable (_id $idType, title $textType, type $intType, description $textType )');
    });
    return _database!;
  }

  Future<NoteClass> insertData(NoteClass note) async {
    print("Note added");
    print(note.title);
    print(note.description);
    Database db = await instance.database;
    int id = await db.rawInsert(
        'INSERT INTO NoteTable(title,type,description) VALUES(?,?,?)',
        [note.title, 0, note.description]);
    print(id);
    note.id = id;
    return note;
  }

  Future<List<NoteClass>> getData() async {
    Database db = await instance.database;
    var data = await db.rawQuery('SELECT * FROM NoteTable');
    List<NoteClass> notes = [];
    data.forEach((element) {
      print(element['_id']);
      print(element['id']);
      print(element);
      notes.add(NoteClass.fromJson(element));
    });
    return notes;
  }

  Future<int> update(NoteClass note) async {
    print("Note updated");
    print(note.title);
    print(note.description);
    print(note.id);
    Database db = await instance.database;
    return db.update('NoteTable', note.toJson(),
        where: '_id = ?', whereArgs: [note.id]);
  }

  Future<int> delete(NoteClass note) async {
    print("Note deleted");
    print(note.title);
    print(note.description);
    print(note.id);
    Database db = await instance.database;
    return db.delete('NoteTable', where: '_id = ?', whereArgs: [note.id]);
  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }
}
