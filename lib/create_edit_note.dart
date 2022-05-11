import 'package:flutter/material.dart';
import 'homepage.dart';
import 'Note_class.dart';
import 'more_options.dart';

// ignore: must_be_immutable
class CreateEditNote extends StatefulWidget {
  int? noteId;
  CreateEditNote(this.noteId, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _NoteState createState() => _NoteState(noteId);
}

class _NoteState extends State<CreateEditNote> {
  int? noteId;
  String _title = '';
  String _content = '';
  Color _noteColor = const Color.fromARGB(255, 28, 29, 204);

  _NoteState(this.noteId);//recieves 0 to create new note or note id to edit

  void _saveNote() {//when pressing the save icon
    setState(() {
      if (noteId == 0) {
        //gives the new note an id by increasing the last id by 1
        noteId = NoteClass.lastId + 1;
        NoteClass(_title, _content, _noteColor);//add new note
      } else {
        var note = NoteClass.getNoteById(noteId)!;//get the note that has thid id
        //edit its content
        note.setTitle = _title;
        note.setColor = _noteColor;
        note.setContent = _content;
      }
      //after changes navigates to the home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  bool isSetColor = false;//to keep set color

  void setColor(Color color) {//when choosing color from color slider
    setState(() {
      _noteColor = color;//chanage note color
      isSetColor = true;
      //to keep changes of title and content if we change them befor choosing color
      //and before saving them, 
      //because choosing color may refill the field with default values
    });
  }

  @override
  Widget build(BuildContext context) {
    if (noteId != 0 && !isSetColor) {
      //get note information to edit
      var note = NoteClass.getNoteById(noteId)!;
      _title = note.getTitle;
      _content = note.getContent;
      _noteColor = note.getColor;
    }

    //print('note id is $noteId');

    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: _noteColor,
      foregroundColor: const Color.fromARGB(255, 44, 42, 42),
      //title according to id
      title: Text(noteId == 0 ? 'New Note' : 'Edit Note'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {//to show more options(delete, duplicate, share, color)
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) =>
                    MoreOptions(noteId, setColor),
              );
            },
            child: const Icon(Icons.more_vert),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () async {//to save chanes, either add new note or edit it
              if (_title.isNotEmpty || _content.isNotEmpty) {
                _saveNote();
              }
            },
            child: const Icon(Icons.save),
          ),
        ),
      ],
    );
  }

  Widget _body(BuildContext ctx) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: _noteTitle(context),
            ),
            const Divider(
              color: Colors.black54,
              height: 5,
            ),
            Flexible(
              child: _noteContent(context),
            ),
          ],
        ),
        top: false, //to allow system intrusion
        bottom: false, //to allow system intrusion
      ),
    );
  }

  Widget _noteTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: EditableText(
        onChanged: (str) {
          str.length < 40? _title = str : str.substring(0,40);
        },
        autofocus: true,
        style: const TextStyle(
          color: Color.fromARGB(255, 55, 48, 160),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        cursorColor: const Color.fromARGB(255, 55, 48, 160),
        backgroundCursorColor: const Color.fromARGB(255, 88, 80, 79),
        controller: TextEditingController(
            text: noteId == 0 && !isSetColor ? 'Type something...' : _title),
        focusNode: FocusNode(),
      ),
    );
  }

  Widget _noteContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: EditableText(
        onChanged: (str) {
          _content = str;
        },
        maxLines: 50, // line limit extendable later
        controller: TextEditingController(
            text: noteId == 0 && !isSetColor ? 'Type something...' : _content),
        focusNode: FocusNode(),
        style: const TextStyle(
          color: Color.fromARGB(255, 88, 80, 79),
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
        backgroundCursorColor: const Color.fromARGB(255, 88, 80, 79),
        cursorColor: const Color.fromARGB(255, 6, 47, 80),
      ),
    );
  }
}
