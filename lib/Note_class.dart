// ignore_for_file: file_names, curly_braces_in_flow_control_structures

import 'note_db.dart';

class NoteClass {
  //private instances
  int _id = 0;
  String _title = '';
  String _content = '';
  int _color = 0;
  String _date = '';
  static int lastId = 0;

  static List<NoteClass> notes = [];
  static bool isFilledList = false;

  NoteClass(this._title, this._content, this._color, this._date) {
    lastId += 1;
    _id = lastId;
    notes.add(this);
    _insert(getId, getTitle, getContent, getColor, _date);
    print(_id);
  }

  NoteClass.fill(
      this._id, this._title, this._content, this._color, this._date) {
    notes.add(this);
    lastId += 1;
  }

  _insert(int id, String title, String content, int color, String date) async {
    String sqlQuery =
        '''insert into notes ('id', 'title', 'content', 'color', 'edit_date') 
            values ($id, $title, $content, $color, $date)''';
    int response = await NoteDB().insertData(sqlQuery);
    print(response);
  }

  static fillListFromDB() async {
    if (!isFilledList) {
      //singleton pattern
      isFilledList = true;
      String sqlQuery = "select * from notes";
      List<Map> data = await NoteDB().readData(sqlQuery);
      print(data.isEmpty);
      for (Map raw in data) {
        NoteClass.fill(raw['id'], raw['title'], raw['content'], raw['color'],
            raw['edit_date']);
      }
    }
  }

  static deleteNoteFromDB(int id) async {
    String sqlQuery = 'DELETE FROM "notes" WHERE id = $id';
    int response = await NoteDB().deleteData(sqlQuery);
    return response;
  }

  static updateNoteInDB(
      int id, String title, String content, int color, String date) async {
    String sqlQuery =
        '''UPDATE 'notes' SET 'title' = $title, 'content' = $content, 
          'color' = $color, 'edit_date' = $date WHERE id = $id ''';
    int response = await NoteDB().updateData(sqlQuery);
  }

  int get getId => _id;
  set setId(int id) => _id = id;

  String get getTitle => _title;
  set setTitle(String title) => _title = title;

  String get getContent => _content;
  set setContent(String content) => _content = content;

  int get getColor => _color;
  set setColor(int color) => _color = color;

  String get getDate => _date;
  set setDate(String date) => _date = date;

  static NoteClass? getNoteById(int? id) {
    for (NoteClass note in notes) if (note.getId == id) return note;
    return null;
  }
}
