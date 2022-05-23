// ignore: file_names
import 'note_db.dart' show NoteDB;

class NoteClass {
  //private instances
  int _id = 0;
  String _title = "";
  String _content = "";
  int _color = 0;
  String _date = "";
  static int lastId = 0;

  static List<NoteClass> notes = [];
  static bool isFilledList = false;

  NoteClass(this._title, this._content, this._color, this._date) {
    lastId += 1;
    _id = lastId;
    notes.add(this);
    _insert(this);
    print(_id);
  }

  NoteClass.fill(
      this._id, this._title, this._content, this._color, this._date) {
    notes.add(this);
    lastId += 1;
  }

  Future<int> _insert(NoteClass note) async {
    Map<String, dynamic> raw = {
      "id": note.getId,
      "title": note.getTitle,
      "content": note.getContent,
      "color": note.getColor,
      "edit_date": note.getDate
    };
    int response = await NoteDB.insertData(raw);
    print(response);
    return response;
  }

  static Future<List> fillListFromDB() async {
    String sqlQuery = "select * from notes";
    List<Map> data = await NoteDB.readData(sqlQuery);
    if (!isFilledList) {
      //singleton pattern
      isFilledList = true;
      print(data.isEmpty);
      for (Map raw in data) {
        NoteClass.fill(raw['id'], raw['title'], raw['content'], raw['color'],
            raw['edit_date']);
      }
    }
    return data;
  }

  static Future<int> deleteNoteFromDB(int id) async {
    String sqlQuery = "DELETE FROM 'notes' WHERE id = $id";
    int response = await NoteDB.deleteData(sqlQuery);
    return response;
  }

  static Future<int> updateNoteInDB(NoteClass note) async {
    Map<String, dynamic> raw = {
      "title": note.getTitle,
      "content": note.getContent,
      "color": note.getColor,
      "edit_date": note.getDate
    };
    int response = await NoteDB.updateData(note.getId, raw);
    return response;
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
    for (NoteClass note in notes) {
      if (note.getId == id) return note;
    }
    return null;
  }
}
