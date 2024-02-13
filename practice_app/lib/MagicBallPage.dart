import 'dart:math';

import 'package:flutter/material.dart';

class MagicBallPage extends StatefulWidget {
  const MagicBallPage({super.key});

  @override
  State<MagicBallPage> createState() => _MagicBallPageState();
}

class _MagicBallPageState extends State<MagicBallPage> {
  var ballNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Magic Ball App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                ballNumber = Random().nextInt(5) + 1;
              });
            },
            child: Image.asset("images/balls/ball$ballNumber.png")),
      ),
    );
  }
}
