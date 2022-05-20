import 'package:sqflite/sqflite.dart';

class NoteDB {
  static Database? _db;

  NoteDB._();

  static Future<Database?> get dataBase async {
    //singleton pattern
    _db ??= await _initDB();
    return _db;
  }

  static Future<Database?> _initDB() async {
    //create data base
    print('creating database...');
    Database noteDB = await openDatabase('motes.db',
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return noteDB;
  }

  static Future<void> _onCreate(Database db, int version) async {
    //called when creating database
    await db.execute('''
    CREATE TABLE "notes"(
      id INTEGER NOT NULL PRIMARY KEY, 
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      color INTEGER NOT NULL,
      edit_date TEXT NOT NULL,
    )
      ''');
  }

  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    //called when changing version to uograde data base
    //e.g. when adding a new table
  }

  static Future<List<Map>> readData(String sql) async {
    Database? noteDB = await NoteDB.dataBase;
    List<Map> response = await noteDB!.rawQuery(sql);
    return response;
  }

  static Future<int> insertData(String sql) async {
    Database? noteDB = await NoteDB.dataBase;
    int response = await noteDB!.rawInsert(sql);
    return response;
  }

  static Future<int> deleteData(String sql) async {
    Database? noteDB = await NoteDB.dataBase;
    int response = await noteDB!.rawDelete(sql);
    return response;
  }

  static Future<int> updateData(String sql) async {
    Database? noteDB = await NoteDB.dataBase;
    int response = await noteDB!.rawUpdate(sql);
    return response;
  }
}
