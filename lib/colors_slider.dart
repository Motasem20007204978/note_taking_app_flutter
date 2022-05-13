import 'package:flutter/material.dart';
import 'Note_class.dart';

// ignore: must_be_immutable
class ColorSlider extends StatefulWidget {
  int? noteId;
  void Function(Color color)? setColor;
  ColorSlider(this.noteId, this.setColor, {Key? key}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  _ColorSliderState createState() => _ColorSliderState(noteId, setColor);
}

class _ColorSliderState extends State<ColorSlider> {
  int? noteId = 0;
  void Function(Color color)? setColor;
  _ColorSliderState(this.noteId, this.setColor);
  //recieves note id to select it on the slider
  //recieves setColor method to set color at app bar and more options container color

  final colors = [
    const Color.fromARGB(255, 28, 29, 204),
    const Color(0xffffffff), // classic white
    const Color(0xfff28b81), // light pink
    const Color(0xfff7bd02), // yellow
    const Color(0xfffbf476), // light yellow
    const Color(0xffcdff90), // light green
    const Color(0xffa7feeb), // turquoise
    const Color(0xffcbf0f8), // light cyan
    const Color(0xffafcbfa), // light blue
    const Color(0xffd7aefc), // plum
    const Color(0xfffbcfe9), // misty rose
    const Color(0xffe6c9a9), // light brown
    const Color(0xffe9eaee) // light gray
  ];

  Color? noteColor;
  int? indexOfCurrentColor; //to check on the new selected color

  @override
  void initState() {
    var note = NoteClass.getNoteById(noteId);
    super.initState();
    noteColor = noteId == 0
        ? const Color.fromARGB(255, 28, 29, 204)
        : Color(note!.getColor);
    indexOfCurrentColor = colors.indexOf(noteColor!);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(colors.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              noteColor = colors[index];
              indexOfCurrentColor = index;
              setColor!(noteColor!);
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: Container(
              child: CircleAvatar(
                //check selected color here
                child: indexOfCurrentColor == index
                    ? const Icon(Icons.check)
                    : null,
                foregroundColor: const Color(0xff595959),
                backgroundColor: colors[index],
              ),
              width: 38.0,
              height: 38.0,
              padding: const EdgeInsets.all(1), // border width
              decoration: const BoxDecoration(
                color: Color(0xffd3d3d3), // border color
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }),
    );
  }
}
