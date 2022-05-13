import 'package:flutter/material.dart';
import 'homepage.dart';
import 'Note_class.dart';
import 'colors_slider.dart';
//import 'package:share/share.dart';

// ignore: must_be_immutable
class MoreOptions extends StatefulWidget {
  int? noteId;
  final void Function(Color color)? setColor;
  MoreOptions(this.noteId, this.setColor, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _MoreOptionsState createState() => _MoreOptionsState(noteId, setColor);
}

class _MoreOptionsState extends State<MoreOptions> {
  int? noteId;
  final void Function(Color color)? _setColor;
  _MoreOptionsState(this.noteId, this._setColor);

  var noteColor = const Color.fromARGB(255, 28, 29, 204);
  bool isSetColor = false;

  void setColor(Color color) {
    setState(() {
      //set note color
      isSetColor = true;
      noteColor = color;
      _setColor!(color); //passes set color to app bar
    });
  }

  @override
  Widget build(BuildContext context) {
    var note = NoteClass.getNoteById(noteId);
    return Container(
      color: noteId == 0 || isSetColor ? noteColor : Color(note!.getColor),
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
      child: Wrap(
        children: <Widget>[
          ListTile(
              leading: _optionLeading(context, Icons.share),
              title: const Text('Share'),
              onTap: () {}),
          const SizedBox(
            height: 50,
          ),
          ListTile(
              leading: _optionLeading(context, Icons.delete),
              title: const Text('Delete permanently'),
              onTap: () {
                if (noteId != 0) {
                  //if it is a new note, cannot be deleted
                  NoteClass.notes.remove(note!);
                  _toHomePage(context);
                }
              }),
          const SizedBox(
            height: 50,
          ),
          ListTile(
              leading: _optionLeading(context, Icons.content_copy),
              title: const Text('Duplicate'),
              onTap: () {
                if (noteId != 0) {
                  //if it was already added note, it can be duplicated
                  //duplicate by adding second copy
                  NoteClass(note!.getTitle, note.getContent, note.getColor, note.getDate);
                  _toHomePage(context);
                }
              }),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              height: 44,
              width: MediaQuery.of(context).size.width,
              child: ColorSlider(noteId, setColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionLeading(BuildContext context, IconData _icon) {
    return CircleAvatar(
      radius: 20,
      child: Icon(_icon),
      backgroundColor: const Color.fromARGB(255, 138, 137, 137),
      foregroundColor: const Color.fromARGB(255, 34, 33, 31),
    );
  }

  Future _toHomePage(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}
