// // only works in mobile

// import 'package:flutter/material.dart';
// // import 'package:wakelock/wakelock.dart';

// class WakelockPage extends StatefulWidget {
//   const WakelockPage({super.key});

//   @override
//   State<WakelockPage> createState() => _WakelockPageState();
// }

// class _WakelockPageState extends State<WakelockPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("wakelock example"),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 Wakelock.enable();
//               });
//             },
//             child: const Text("Enable Wakelock"),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 Wakelock.disable();
//               });
//             },
//             child: const Text("Disable Wakelock"),
//           ),
//           FutureBuilder(
//             future: Wakelock.enabled,
//             builder: (context, AsyncSnapshot<bool> snapshot) {
//               if (!snapshot.hasData) {
//                 return Container();
//               }
//               return Text('The wakelock is currently '
//                   '${snapshot.hasData ? 'enabled' : 'disabled'}.');
//             },
//           ),
//         ],
//       )),
//     );
//   }
// }
