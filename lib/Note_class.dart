// ignore_for_file: file_names, curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart' show Color;
import 'package:flutter/material.dart';

class NoteClass {
  //private instances
  int _id = 0;
  String _title = '';
  String _content = '';
  Color _color = const Color.fromARGB(255, 28, 29, 204);
  //DateTime? _date;
  static int lastId = 0;

  static List<NoteClass> notes = [];

  NoteClass(this._title, this._content, this._color) {
    // _date = DateTime.now();
    lastId += 1;
    _id = lastId;
    notes.add(this);
  }

  int get getId => _id;
  set setId(int id) => _id = id;

  String get getTitle => _title;
  set setTitle(String title) => _title = title;

  String get getContent => _content;
  set setContent(String content) => _content = content;

  Color get getColor => _color;
  set setColor(Color color) => _color = color;

  // DateTime? get getDate => _date;
  // set setDate(DateTime date) => _date = date;

  static NoteClass? getNoteById(int? id) {
    for (NoteClass note in notes) if (note.getId == id) return note;
    return null;
  }
}
