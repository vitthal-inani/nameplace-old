import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'gamepage.dart';
import 'package:provider/provider.dart';
import 'globals.dart';
import 'dialogs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  var name;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: Colors.blue,
            body: Center(
              child: Container(
                alignment: Alignment.center,
                height: 450,
                child: Dialog(
                    insetPadding: EdgeInsets.all(50),
                    elevation: 10,
                    child: Form(
                      key: _key,
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Text(
                              "Enter your name",
                              style:
                                  TextStyle(fontSize: 32, color: Colors.blue),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter name";
                                }
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: 26, color: Colors.black),
                              onSaved: (value) {
                                name = value;
                              },
                            ),
                            Spacer(),
                            RaisedButton(
                              elevation: 10,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "Enter",
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onPressed: () {
                                if (_key.currentState.validate()) {
                                  _key.currentState.save();
                                  if (roomname == "") {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("No Room"),
                                            elevation: 10,
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("OK"))
                                            ],
                                          );
                                        });
                                    return;
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainApp(name)));
                                }
                              },
                              color: Colors.blue,
                            ),
                            Spacer(),
                            Row(
                              children: [
                                RaisedButton(
                                  elevation: 20,
                                  color: Colors.blue,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Join",
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return JoinRoom();
                                        });
                                  },
                                ),
                                Spacer(),
                                RaisedButton(
                                  elevation: 20,
                                  color: Colors.blue,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Create",
                                      style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CreateRoom();
                                        });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ));
      }),
    );
  }
}

class MainApp extends StatelessWidget {
  final String name;

  MainApp(this.name);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalState>(
      create: (_) =>
          GlobalState(false, [randomLetter()], List<DataEntry>(), name),
      child: Scaffold(body: GamePage()),
    );
  }
}
