import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'globals.dart' as globals;
import 'dialogs.dart';
import 'main.dart';

class StartBox extends StatelessWidget {
  @override
  var name;
  final _key = GlobalKey<FormState>();
  final letter = globals.randomLetter();

  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final room = Provider.of<globals.RoomState>(context);
    print(room.roomname);
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: _screenSize.height * 0.55,
        width: _screenSize.width * 0.9,
        child: Dialog(
            insetPadding: EdgeInsets.all(_screenSize.height / 16),
            elevation: 10,
            child: Form(
              key: _key,
              child: Padding(
                padding: EdgeInsets.all(_screenSize.height / 40),
                child: Column(
                  children: [
                    Text(
                      "Enter your name",
                      style: TextStyle(fontSize: 32, color: Colors.blue),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter name";
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 26, color: Colors.black),
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
                              fontSize: _screenSize.height / 25.5,
                              color: Colors.white),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      onPressed: () {
                        print(room.roomname.isEmpty);
                        FocusScope.of(context).unfocus();
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          if (room.roomname == "") {
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
                                  builder: (context) =>
                                      MainApp(name, globals.firstLetter)));
                        }
                      },
                      color: Colors.blue,
                    ),
                    Spacer(),
                    (room.roomname == " ")
                        ? Row(
                            children: [
                              RaisedButton(
                                elevation: 20,
                                color: Colors.blue,
                                child: Container(
                                  width: _screenSize.width * 0.15,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Join",
                                    style: TextStyle(
                                      fontSize: _screenSize.height / 42.5,
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
                                  width: _screenSize.width * 0.2,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Create",
                                    style: TextStyle(
                                      fontSize: _screenSize.height / 42.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CreateRoom(
                                          letter: letter,
                                        );
                                      });
                                },
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(room.roomname),
                              ),
                              IconButton(
                                icon: Icon(Icons.close_sharp),
                                onPressed: () {
                                  room.roomname = " ";
                                },
                              )
                            ],
                          ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
