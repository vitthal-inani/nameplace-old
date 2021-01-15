import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nameplace/Models/User.dart';
import 'package:nameplace/Screens/Login.dart';
import 'package:provider/provider.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Game(0, ""),
      child: MaterialApp(
        home: Scaffold(
          body: FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done)
                return Login();
              return CircularProgressIndicator();
            }
          ),
        ),
      ),
    );
  }
}
