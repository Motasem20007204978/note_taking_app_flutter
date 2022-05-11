import 'package:flutter/material.dart';
import 'list_notes.dart';
import 'Note_class.dart';
import 'create_edit_note.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 28, 39, 204),
        title: const Text('My Notes'),
        elevation: 1,
      ),
      body: NoteClass.notes.isEmpty ? const EmptyNote() : const NotesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {//navigate to create new note page
          Navigator.push(
            context,
            //passes 0 to make new page note
            MaterialPageRoute(builder: (context) => CreateEditNote(0)),
          );
        },
        tooltip: 'create note',//description when hover the wedgit
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        backgroundColor: const Color.fromARGB(255, 28, 29, 204),
      ),
    );
  }
}
