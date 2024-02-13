import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/MyNavPage.dart';
import 'package:practice_app/main.dart';

// ignore: must_be_immutable
class MyQuizPage extends StatefulWidget {
  MyQuizPage({super.key, required this.qIndex, required this.score});

  // ignore: prefer_typing_uninitialized_variables
  var qIndex;
  // ignore: prefer_typing_uninitialized_variables
  var score;

  @override
  State<MyQuizPage> createState() => MyQuizPageState();
}

class MyQuizPageState extends State<MyQuizPage> {
  var resultText = "Hello";
  final _questions = const [
    {
      'questionText': 'Q1. Who created Flutter?',
      'answers': [
        {'text': 'Facebook', 'score': -2},
        {'text': 'Adobe', 'score': -2},
        {'text': 'Google', 'score': 10},
        {'text': 'Microsoft', 'score': -2},
      ],
    },
    {
      'questionText': 'Q2. What is Flutter?',
      'answers': [
        {'text': 'Android Development Kit', 'score': -2},
        {'text': 'IOS Development Kit', 'score': -2},
        {'text': 'Web Development Kit', 'score': -2},
        {
          'text':
              'SDK to build beautiful IOS, Android, Web & Desktop Native Apps',
          'score': 10
        },
      ],
    },
    {
      'questionText': ' Q3. Which programming language is used by Flutter',
      'answers': [
        {'text': 'Ruby', 'score': -2},
        {'text': 'Dart', 'score': 10},
        {'text': 'C++', 'score': -2},
        {'text': 'Kotlin', 'score': -2},
      ],
    },
    {
      'questionText': 'Q4. Who created Dart programming language?',
      'answers': [
        {'text': 'Lars Bak and Kasper Lund', 'score': 10},
        {'text': 'Brendan Eich', 'score': -2},
        {'text': 'Bjarne Stroustrup', 'score': -2},
        {'text': 'Jeremy Ashkenas', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q5. Is Flutter for Web and Desktop available in stable version?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    // converted answers into List of Maps
    var answers =
        _questions[widget.qIndex]['answers'] as List<Map<String, Object>>;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple[200],
          title: const Text(
            "Flutter Quiz",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false),
      body: widget.qIndex < _questions.length - 1
          ? Center(
              child: Container(
                height: 300,
                width: 400,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _questions[widget.qIndex]['questionText'].toString(),
                      style: const TextStyle(fontSize: 22),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: answers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                setState(
                                  () {
                                    widget.score += int.parse(
                                        answers[index]['score'].toString());
                                    widget.qIndex += 1;
                                  },
                                );
                              },
                              child: Text(answers[index]['text'].toString(),
                                  style: const TextStyle(fontSize: 18)),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: TextButton(
                onPressed: () {
                  getResultPhrase();
                  Widget tryAgainButton = TextButton(
                    child: const Text("Try Again"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => MyQuizPage(qIndex: 0, score: 0),
                        ),
                      );
                    },
                  );
                  Widget quitButton = TextButton(
                    child: const Text("Quit"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                      );
                    },
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: const Text("Quiz Result"),
                    content:
                        Text("Your Score is ${widget.score}. \n${resultText}"),
                    actions: [tryAgainButton, quitButton],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                child:
                    const Text("Show Result", style: TextStyle(fontSize: 18)),
              ),
            ),
    );
  }

  void getResultPhrase() {
    if (widget.score >= 31) {
      resultText = 'You are awesome!';
    } else if (widget.score >= 21) {
      resultText = 'Pretty likeable!';
    } else if (widget.score >= 11) {
      resultText = 'You need to work more!';
    } else if (widget.score >= 1) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
    }
  }
}
