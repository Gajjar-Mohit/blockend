import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Flutter Dapp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textFieldController = TextEditingController();
  String name = "";
  Future showTextFieldPopup() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter your name"),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Enter your name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  name = _textFieldController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Your Flutter DApp"),
          centerTitle: true,
        ),
        body: Center(
          child: SizedBox(
            width: 700,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  name.isNotEmpty
                      ? Text(
                          "Hello, ${_textFieldController.text}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : const Text(""),
                  Image.asset("assets/image.png"),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Text(
            "Crafting with ❤️ by Mohit Gajjar",
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showTextFieldPopup();
          },
          child: const Icon(Icons.message_outlined),
        ));
  }
}
