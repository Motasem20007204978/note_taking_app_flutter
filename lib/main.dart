import 'homepage.dart';
import 'package:flutter/material.dart';
import 'Note_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteClass.fillListFromDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Note Taking App',
      debugShowCheckedModeBanner: false,
      home: GetStartedPage(),
    );
  }
}

//get started page
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo image
            Image.asset('images/note.png'),
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              //button to goto home page
              child: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 38, 28, 170),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
