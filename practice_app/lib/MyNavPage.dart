import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class MyNavPage extends StatelessWidget {
  const MyNavPage({super.key});

  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[200],
          appBar: AppBar(
              title: const Text("Flutter Navigation"),
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.web)),
                Tab(icon: Icon(Icons.list_alt)),
                Tab(
                  icon: Icon(Icons.change_circle),
                )
              ])),
          body: TabBarView(
            children: [
              MyUrlPage(),
              MyWebSocketPage(
                channel: WebSocketChannel.connect(
                    Uri.parse("wss://echo.websocket.org")),
              ),
              MyListViewPage(
                tasks: List<Task>.generate(
                  10,
                  (index) => Task("Task $index", "Task Description $index"),
                ),
              ),
              const MyDataUpdatePage(),
            ],
          ),
        ));
  }
}

// URL's in flutter
class MyUrlPage extends StatelessWidget {
  const MyUrlPage({super.key});

  _launchURLBrowser() async {
    var url = Uri.parse(
        "https://www.geeksforgeeks.org/routes-and-navigator-in-flutter/?ref=lbp");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Can't launch URL");
    }
  }

  _sendMail() async {
    var url = Uri.parse("mailto:ghanshyam.m.oza@gmail.com");
    if (await canLaunchUrl(url)) {
      return await launchUrl(url);
    } else {
      throw Exception("Cannot Send Mail");
    }
  }

  // works in Mobile Application
  _sendSMS() async {
    var url = Uri.parse("sms:7405711794");
    if (await canLaunchUrl(url)) {
      return await launchUrl(url);
    } else {
      throw Exception("Cannot send SMS");
    }
  }

  // make call in default call app in mobile
  _makeCall() async {
    var url = Uri.parse("tel:7405711794");
    if (await canLaunchUrl(url)) {
      return await launchUrl(url);
    } else {
      throw Exception("Cannot Make Call");
    }
  }
  // for opening URL in app
  // _launchURLApp() async {
  //   var url = Uri.parse(
  //       "https://www.geeksforgeeks.org/routes-and-navigator-in-flutter/?ref=lbp");
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     print("Can't launch URL");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _launchURLBrowser,
            child: const Text("Open URL in Browser"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _sendMail,
            child: const Text("Mail Me"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _sendSMS,
            child: const Text("SMS Me"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _makeCall,
            child: const Text("Call Me"),
          ),
          // for Opening URL in app
          // ElevatedButton(
          //   onPressed: _launchURLApp,
          //   child: const Text("Open in App"),
          // )
        ],
      )),
    );
  }
}

// Web Socket in flutter
class MyWebSocketPage extends StatefulWidget {
  final WebSocketChannel channel;
  const MyWebSocketPage({required this.channel});

  @override
  State<MyWebSocketPage> createState() => _MyWebSocketPageState();
}

class _MyWebSocketPageState extends State<MyWebSocketPage> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Web Socket Channel")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                decoration:
                    const InputDecoration(labelText: "Send Any Message"),
                controller: editingController,
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        child: const Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (editingController.text.isNotEmpty) {
      widget.channel.sink.add(editingController.text);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}

// interface for task
class Task {
  final String task_name;
  final String task_description;

  Task(this.task_name, this.task_description);
}

class MyListViewPage extends StatefulWidget {
  final List<Task> tasks;
  const MyListViewPage({required this.tasks});

  @override
  State<MyListViewPage> createState() => _MyListViewPageState();
}

class _MyListViewPageState extends State<MyListViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.tasks[index].task_name),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyDescriptionPage(task: widget.tasks[index])));
            },
          );
        },
      ),
    );
  }
}

class MyDescriptionPage extends StatelessWidget {
  final Task task;
  const MyDescriptionPage({required this.task});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task.task_name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(task.task_description),
      ),
    );
  }
}

// Updationg and fetching data on internet using http
// Interface for album
class Album {
  final String id;
  final String title;

  @override
  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(id: json["id"].toString(), title: json["title"]);
  }
}

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to load Album");
  }
}

Future<Album> createAlbum(String title) async {
  final http.Response response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    // ignore: avoid_print
    print("Successful");
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

Future<Album> updateAlbum(String title) async {
  final http.Response response = await http.put(
      Uri.parse("https://jsonplaceholder.typicode.com/albums/1"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'title': title}));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Failed to Update Album");
  }
}

Future<Album> deleteAlbum(String id) async {
  // ignore: avoid_print
  print("${id.runtimeType} $id");
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to delete album.');
  }
}

class MyDataUpdatePage extends StatefulWidget {
  const MyDataUpdatePage({super.key});

  @override
  State<MyDataUpdatePage> createState() => _MyDataUpdatePageState();
}

class _MyDataUpdatePageState extends State<MyDataUpdatePage> {
  final TextEditingController _editingController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  late Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data?.title ?? "Deleted"),
                      TextFormField(
                        controller: _controller,
                        decoration:
                            const InputDecoration(hintText: "Enter Title"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _editingController,
                        decoration:
                            const InputDecoration(hintText: "Enter Text"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureAlbum = createAlbum(_controller.text);
                          });
                        },
                        child: const Text("Create Album"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureAlbum = updateAlbum(_editingController.text);
                          });
                        },
                        child: const Text("Update Data"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _futureAlbum = deleteAlbum(snapshot.data!.id);
                          });
                        },
                        child: const Text("Delete Data"),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("$snapshot.error");
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
