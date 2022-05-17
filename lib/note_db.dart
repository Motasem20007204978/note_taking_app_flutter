import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/widgets.dart';

class NoteDB {
  static Database? _db;

  Future<Database?> get dataBase async {
    //singleton pattern
    _db ??= await _initDB();
    return _db;
  }

  Future<Database?> _initDB() async {
    //create data base
    print('creating database');
    String dbPath = await getDatabasesPath();
    print(dbPath);
    String path = join(dbPath, 'motes_database.db');
    Database noteDB = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return noteDB;
  }

  _onCreate(Database db, int version) async {
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

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    //called when changing version to uograde data base
    //e.g. when adding a new table
  }

  Future<List<Map>> readData(String sql) async {
    Database? noteDB = await dataBase;
    List<Map> response = await noteDB!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? noteDB = await dataBase;
    int response = await noteDB!.rawInsert(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? noteDB = await dataBase;
    int response = await noteDB!.rawDelete(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? noteDB = await dataBase;
    int response = await noteDB!.rawUpdate(sql);
    return response;
  }
}
