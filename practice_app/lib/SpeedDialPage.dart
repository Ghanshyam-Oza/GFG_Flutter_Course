import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialPage extends StatelessWidget {
  const SpeedDialPage({super.key});

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 28.0),
      backgroundColor: Colors.deepPurple[200],
      visible: true,
      curve: Curves.bounceInOut,
      children: [
        SpeedDialChild(
          child: const Icon(
            Icons.chrome_reader_mode,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple[200],
          onTap: () {
            print("Read Pressed");
          },
          label: 'Read',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.deepPurple[200],
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.create,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple[200],
          onTap: () {
            print("Write Pressed");
          },
          label: 'Write',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.deepPurple[200],
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.laptop_chromebook,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple[200],
          onTap: () {
            print("Code Pressed");
          },
          label: 'Code',
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.deepPurple[200],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Speed Dial Example",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[200],
      ),
      body: const Center(
        child: Text("Welcome to Flutter"),
      ),
      floatingActionButton: buildSpeedDial(),
    );
  }
}
