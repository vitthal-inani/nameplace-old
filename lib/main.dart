import 'package:flutter/material.dart';
import 'gamepage.dart';
import 'package:provider/provider.dart';
import 'globals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<GlobalState>(
        create: (_) => GlobalState(false, [randomLetter()], List<DataEntry>()),
        child: Scaffold(body: GamePage()),
      ),
    );
  }
}
