import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var greetMsg = "Hello There!";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "new_app",
      home: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: Center(
          child: Container(
            height: 300,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepPurple,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  greetMsg,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        greetMsg = "Hello Welcome!";
                      });
                    },
                    icon: const Icon(Icons.waving_hand),
                    label: const Text("Say Hi")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
