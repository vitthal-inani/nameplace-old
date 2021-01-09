import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nameplace/startbox.dart';
import 'gamepage.dart';
import 'package:provider/provider.dart';
import 'globals.dart' as global;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return ChangeNotifierProvider<global.RoomState>(
        create: (_) => global.RoomState(" "),
        child: MaterialApp(home: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.blue,
            body: StartBox(),
          );
        })));
  }
}

class MainApp extends StatelessWidget {
  final String name;
  final String letter;

  MainApp(this.name, this.letter);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<global.GlobalState>(
      create: (_) =>
          global.GlobalState(0, [letter],[letter], List<global.DataEntry>(), false),
      child: Scaffold(body: GamePage()),
    );
  }
}
