import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDB {
  static Database? _db;

  NoteDB();

  Future<Database?> get dataBase async {
    //singleton pattern
    if (_db == null) {
      _db = await _initDB();
      return _db;
    }
    return _db;
  }

  _initDB() async {
    //create data base
    print('creating database');
    Database noteDB = await openDatabase('notes.db',
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return noteDB;
  }

  _onCreate(Database db, int version) async {
    //called when creating database
    await db.execute('''
    CREATE TABLE "notes"(
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      color INTEGER NOT NULL,
      edit_date TEXT NOT NULL,
    )
      ''');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    //called when changing version to uograde data base
    //e.g. when adding a new table
  }

  readData(String sql) async {
    Database? noteDB = await dataBase;
    var response = await noteDB!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? noteDB = await dataBase;
    int response = await noteDB!.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? noteDB = await dataBase;
    int response = await noteDB!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? noteDB = await dataBase;
    int response = await noteDB!.rawUpdate(sql);
    return response;
  }
}
