import 'dart:math';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:developer' as developer;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:flutter/services.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:practice_app/MagicBallPage.dart';
import 'package:practice_app/MyNavPage.dart';
import 'package:practice_app/MyQuizPage.dart';
import 'package:practice_app/PdfGenPage.dart';
import 'package:practice_app/SpeedDialPage.dart';
import 'package:practice_app/WakelockPage.dart';
import 'package:practice_app/flutter_firebase.dart';
import 'package:practice_app/to_do.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:flutter/physics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCVRHlHs0AaWVciQj08JAXuPY9GX3BvxPc",
          appId: "1:130245795170:android:5976d35c47f06dd2e4603b",
          messagingSenderId: "130245795170",
          projectId: "flutter-firebase-286ed"));
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse},
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 184, 122, 251)),
        useMaterial3: true,
      ),
      home: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: const Text("Flutter GMO",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const MyStylesPage()));
                  },
                  child: const Text("Styles")),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                const MyFormValidationPage()));
                  },
                  child: const Text("Forms")),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const MyNavPage()));
                  },
                  child: const Text("Navigation")),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                MyQuizPage(qIndex: 0, score: 0)));
                  },
                  child: const Text("Quiz")),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home, color: Colors.white)),
              Tab(icon: Icon(Icons.list, color: Colors.white)),
              Tab(icon: Icon(Icons.expand, color: Colors.white)),
              Tab(icon: Icon(Icons.check_box_sharp, color: Colors.white)),
              Tab(icon: Icon(Icons.list_alt, color: Colors.white)),
              Tab(icon: Icon(Icons.leaderboard, color: Colors.white)),
              Tab(
                  icon: Icon(
                Icons.grid_4x4_sharp,
                color: Colors.white,
              ))
            ],
          ),
        ),
        body: const TabBarView(children: [
          MyHomePage(),
          MyListPage(),
          MyExpansionListPage(),
          MyAlertDialogBoxPage(),
          MyShowDialogPage(),
          MyProgressBarPage(),
          MyGridViewPage()
        ]),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme:
              const IconThemeData(size: 28.0, color: Colors.white),
          backgroundColor: Colors.deepPurple,
          visible: true,
          curve: Curves.bounceInOut,
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.chrome_reader_mode,
                color: Colors.white,
              ),
              backgroundColor: Colors.deepPurple,
              onTap: () {
                print("Read Pressed");
              },
              label: 'Read',
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.deepPurple,
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.create,
                color: Colors.white,
              ),
              backgroundColor: Colors.deepPurple,
              onTap: () {
                print("Write Pressed");
              },
              label: 'Write',
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.deepPurple,
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.laptop_chromebook,
                color: Colors.white,
              ),
              backgroundColor: Colors.deepPurple,
              onTap: () {
                print("Code Pressed");
              },
              label: 'Code',
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});
  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: ListView(
          itemExtent: 280,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            for (var i = 0; i < 20; i++)
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple[200],
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(4, 4),
                          blurRadius: 4),
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 4)
                    ],
                  ),
                  child: Center(
                    child: ListTile(
                      leading:
                          const Image(image: AssetImage("images/flutter.png")),
                      title: Text("This is ${i}th list item"),
                      textColor: Colors.white,
                      hoverColor: Colors.pink[200],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  var greetMsg = "Hello There!";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}

class MyExpansionListPage extends StatefulWidget {
  const MyExpansionListPage({super.key});

  @override
  State<MyExpansionListPage> createState() => _MyExpansionListPageState();
}

class _MyExpansionListPageState extends State<MyExpansionListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: ListView(
        children: <Widget>[
          ExpansionTileCard(
            title: const Text("Tap to Expand"),
            leading: const CircleAvatar(child: Icon(Icons.favorite)),
            subtitle: const Text("This is the subtitle"),
            children: <Widget>[
              const Divider(height: 20.0, thickness: 20.0),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset('images/python.png')),
            ],
          )
        ],
      ),
    );
  }
}

class MyAlertDialogBoxPage extends StatefulWidget {
  const MyAlertDialogBoxPage({super.key});

  @override
  State<MyAlertDialogBoxPage> createState() => _MyAlertDialogBoxPageState();
}

class _MyAlertDialogBoxPageState extends State<MyAlertDialogBoxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[200],
        body: AlertDialog(
          title: const Text("Welcome"),
          content: const Text("GMO Flutter app"),
          actions: [
            TextButton(
                onPressed: () {
                  developer.log("Yes button clicked");
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => const MyApp()));
                },
                child: const Text("Yes")),
            TextButton(
                onPressed: () {
                  developer.log("no button is clicked");
                  // if (Platform.isAndroid) {
                  //   SystemNavigator.pop();
                  // } else if (Platform.isIOS) {
                  //   exit(0);
                  // }
                },
                child: const Text("No"))
          ],
        ));
  }
}

class MyShowDialogPage extends StatefulWidget {
  const MyShowDialogPage({super.key});

  @override
  State<MyShowDialogPage> createState() => _MyShowDialogPageState();
}

class _MyShowDialogPageState extends State<MyShowDialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SimpleDialog(
      title:
          const Text("Select Page", style: TextStyle(fontFamily: "Pacifico")),
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const MyApp()));
            },
            child: const Text("Home Page")),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const MyListPage()));
            },
            child: const Text("List Page"))
      ],
    ));
  }
}

class MyProgressBarPage extends StatefulWidget {
  const MyProgressBarPage({super.key});

  @override
  State<MyProgressBarPage> createState() => _MyProgressBarPageState();
}

class _MyProgressBarPageState extends State<MyProgressBarPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        LinearProgressIndicator(
          backgroundColor: Colors.black,
          valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
          minHeight: 10,
        ),
        SizedBox(
          height: 10,
        ),
        CircularProgressIndicator(
          backgroundColor: Colors.black,
          valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
          strokeWidth: 10,
        )
      ]),
    ));
  }
}

class MyGridViewPage extends StatefulWidget {
  const MyGridViewPage({super.key});

  @override
  State<MyGridViewPage> createState() => _MyGridViewPageState();
}

class _MyGridViewPageState extends State<MyGridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          children: [
            Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(color: Colors.green)),
            Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(color: Colors.black)),
            Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(color: Colors.blueGrey)),
            Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(color: Colors.cyan)),
            Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(color: Colors.indigoAccent))
          ]),
    ));
  }
}

class MyStylesPage extends StatelessWidget {
  const MyStylesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Styles and Animation"),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.animation)),
              Tab(icon: Icon(Icons.label)),
              Tab(icon: Icon(Icons.square)),
              Tab(icon: Icon(Icons.favorite)),
              Tab(icon: Icon(Icons.local_attraction)),
              Tab(icon: Icon(Icons.key)),
            ]),
          ),
          body: const TabBarView(children: [
            MySkeletonTextAnimationPage(),
            MyLazyLoaderPage(),
            MyPhysicsCardPage(),
            MyHeroAnimationPage(),
            MyLottieAnimationPage(),
            MyKeyUsagePage(),
          ]),
        ));
  }
}

class MySkeletonTextAnimationPage extends StatefulWidget {
  const MySkeletonTextAnimationPage({super.key});

  @override
  State<MySkeletonTextAnimationPage> createState() =>
      _MySkeletonTextAnimationPageState();
}

class _MySkeletonTextAnimationPageState
    extends State<MySkeletonTextAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        SkeletonAnimation(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 236, 236, 236))))),
        SkeletonAnimation(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 236, 236, 236))))),
        SkeletonAnimation(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 236, 236, 236)))))
      ]),
    ));
  }
}

class MyLazyLoaderPage extends StatefulWidget {
  const MyLazyLoaderPage({super.key});

  @override
  State<MyLazyLoaderPage> createState() => _MyLazyLoaderPageState();
}

class _MyLazyLoaderPageState extends State<MyLazyLoaderPage> {
  List data = [];
  bool isLoading = false;
  int increment = 5;
  int currentLength = 0;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));
    for (int i = 0; i <= currentLength + increment; i++) {
      data.add(i);
    }

    setState(() {
      isLoading = false;
      currentLength = data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LazyLoadScrollView(
      isLoading: isLoading,
      onEndOfPage: _loadMore,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => {print("Clicked")},
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(color: Colors.black),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "List Item",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class MyPhysicsCardPage extends StatefulWidget {
  const MyPhysicsCardPage({super.key});

  @override
  State<MyPhysicsCardPage> createState() => MyPhysicsCardPageState();
}

class MyPhysicsCardPageState extends State<MyPhysicsCardPage>
    with SingleTickerProviderStateMixin {
  late Animation<Alignment> _animation;
  late AnimationController _controller;
  Alignment _dragAlignment = Alignment.center;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
    // evaluating velocity
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class MyHeroAnimationPage extends StatefulWidget {
  const MyHeroAnimationPage({super.key});

  @override
  State<MyHeroAnimationPage> createState() => MyHeroAnimationPageState();
}

class MyHeroAnimationPageState extends State<MyHeroAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHeroAnimationPage2()))
          },
          child: Hero(
            tag: "Swift",
            child: Image.asset(
              "images/swift.png",
              height: 100,
              width: 100,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHeroAnimationPage2 extends StatelessWidget {
  const MyHeroAnimationPage2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Swift Programming")),
      body: Hero(
        tag: "Swift",
        child: Image.asset(
          "Images/swift.png",
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}

class MyLottieAnimationPage extends StatefulWidget {
  const MyLottieAnimationPage({super.key});

  @override
  State<MyLottieAnimationPage> createState() => _MyLottieAnimationPageState();
}

class _MyLottieAnimationPageState extends State<MyLottieAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        "animations/hand_sanitizer.json",
        repeat: true,
        reverse: false,
        animate: true,
      ),
    );
  }
}

class MyKeyUsagePage extends StatefulWidget {
  const MyKeyUsagePage({super.key});

  @override
  State<MyKeyUsagePage> createState() => _MyKeyUsagePage();
}

class _MyKeyUsagePage extends State<MyKeyUsagePage> {
  List<Widget> tiles = [
    StatefulColorTile(key: UniqueKey()),
    StatefulColorTile(key: UniqueKey()),
  ];

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: tiles,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTiles,
        child: const Icon(
          Icons.change_circle,
          size: 40.0,
        ),
      ),
    );
  }
}

class UniqueColorGenerator {
  static List colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.indigo,
    Colors.amber,
    Colors.black,
  ];
  static Random random = Random();
  static Color getColor() {
    if (colorOptions.isNotEmpty) {
      return colorOptions.removeAt(random.nextInt(colorOptions.length));
    } else {
      return Color.fromARGB(random.nextInt(256), random.nextInt(256),
          random.nextInt(256), random.nextInt(256));
    }
  }
}

class StatefulColorTile extends StatefulWidget {
  const StatefulColorTile({super.key});
  @override
  State<StatefulColorTile> createState() => _StatefulColorTileState();
}

class _StatefulColorTileState extends State<StatefulColorTile> {
  late Color color;
  @override
  void initState() {
    super.initState();
    color = UniqueColorGenerator.getColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: color,
    );
  }
}

class MyFormValidationPage extends StatefulWidget {
  const MyFormValidationPage({super.key});

  @override
  State<MyFormValidationPage> createState() => _MyFormValidationPageState();
}

class _MyFormValidationPageState extends State<MyFormValidationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var isLoading = false;
  String email = "";
  String password = "";

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    print(email);
    _formKey.currentState!.save();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const PrintDataPage(),
            settings: RouteSettings(
              arguments: email,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forms in Flutter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                "Form-Validation In Flutter ",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter a valid password!';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => _submit(), child: const Text("Submit")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrintDataPage extends StatelessWidget {
  const PrintDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(title: const Text("Your Details")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Your Email-id is: $email",
          style: const TextStyle(color: Colors.blueGrey, fontSize: 30),
        ),
      ),
    );
  }
}
