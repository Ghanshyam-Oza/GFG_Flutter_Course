import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyUsersPage extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  MyUsersPage({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Firestore"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Enter your name'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Enter your age'),
              ),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'Enter your city'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  await users.add({
                    'name': _nameController.text,
                    'age': int.parse(_ageController.text),
                    'city': _cityController.text
                  }).then((value) => print("User added"));
                },
                child: const Text("Submit"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "List of All Users",
                style: TextStyle(fontSize: 20.0),
              ),
              // FutureBuilder<DocumentSnapshot>(
              //   future: users.doc("gbZO6VdQkFVdkbmZBBlh").get(),
              //   builder: (BuildContext context,
              //       AsyncSnapshot<DocumentSnapshot> snapshot) {
              //     if (snapshot.hasError) {
              //       return Text("Something went wrong");
              //     }

              //     if (snapshot.hasData && !snapshot.data!.exists) {
              //       return Text("Document does not exist");
              //     }

              //     if (snapshot.connectionState == ConnectionState.done) {
              //       Map<String, dynamic> data =
              //           snapshot.data!.data() as Map<String, dynamic>;
              //       return Text(
              //           "Name: ${data['name']} \nAge: ${data['age']} \nCity: ${data['city']}");
              //     }

              //     return const CircularProgressIndicator();
              //   },
              // )
              StreamBuilder(
                stream: users.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Expanded(
                    child: ListView(
                      children: snapshot.data!.docs.map((document) {
                        return Container(
                          child: Text(
                            document['name'],
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
