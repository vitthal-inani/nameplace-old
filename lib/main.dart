import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'gamepage.dart';
import 'package:provider/provider.dart';
import 'globals.dart' as global;
import 'dialogs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  var name;
  final _key = GlobalKey<FormState>();
  var letter = global.randomLetter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        final _screenSize = MediaQuery.of(context).size;
        return Scaffold(
            backgroundColor: Colors.blue,
            body: Center(
              child: Container(
                alignment: Alignment.center,
                height: _screenSize.height*0.55,
                width: _screenSize.width*0.9,
                child: Dialog(
                    insetPadding: EdgeInsets.all(_screenSize.height/16),
                    elevation: 10,
                    child: Form(
                      key: _key,
                      child: Padding(
                        padding: EdgeInsets.all(_screenSize.height/40),
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
                                      fontSize: _screenSize.height/25.5, color: Colors.white),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onPressed: () {
                                print(global.roomname.isEmpty);
                                FocusScope.of(context).unfocus();
                                if (_key.currentState.validate()) {
                                  _key.currentState.save();
                                  if (global.roomname == "") {
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
                                          builder: (context) => MainApp(name,global.firstLetter)));
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
                                        fontSize: _screenSize.height/32.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    await showDialog(
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
                                        fontSize: _screenSize.height/32.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CreateRoom(
                                            letter:letter,
                                          );
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
  final String letter;
  MainApp(this.name,this.letter);
  @override
  Widget build(BuildContext context) {
    global.game = GamePage();
    return ChangeNotifierProvider<global.GlobalState>(
      create: (_) =>
          global.GlobalState(false, [letter], List<global.DataEntry>(), name,false),
      child: Scaffold(body: global.game),
    );
  }
}
