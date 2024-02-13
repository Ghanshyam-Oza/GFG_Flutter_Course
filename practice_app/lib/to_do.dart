import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  // list of tasks
  List toDoTask = [
    ["Create a new App", false],
    ["Start with new Course", false],
  ];

  // text editing controller
  final _controller = TextEditingController();

  // toggle boolean value when user clicks on CheckBar
  void onChecked(bool? value, int index) {
    setState(() {
      toDoTask[index][1] = !toDoTask[index][1];
    });
  }

  // triggered when save button is clicked
  void createTask() {
    setState(() {
      toDoTask.add([_controller.text, false]);
    });
    _controller.clear();
    Navigator.pop(context);
  }

  // triggered when user delete the task
  void deleteTask(int index) {
    setState(() {
      toDoTask.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "To Do App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade300,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogBoxPage(
                  controller: _controller, createTask: createTask);
            },
          );
        },
        backgroundColor: Colors.deepPurple.shade300,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: toDoTask.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          deleteTask(index);
                        },
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                      )
                    ],
                  ),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.deepPurple.shade300),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Checkbox(
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => const BorderSide(
                                  width: 3.0, color: Colors.white),
                            ),
                            value: toDoTask[index][1],
                            onChanged: ((value) => onChecked(value, index)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            toDoTask[index][0],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                decoration: toDoTask[index][1]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class DialogBoxPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final VoidCallback createTask;
  const DialogBoxPage(
      {super.key, required this.controller, required this.createTask});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 100,
        width: 100,
        child: Column(children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: "Add Task", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: createTask,
                child: const Text("Save"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
