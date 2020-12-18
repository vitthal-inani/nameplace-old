import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

class JoinRoom extends StatefulWidget {
  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final _key = GlobalKey<FormState>();
  bool _loading = false;
  String roomName = "";
  String warning = "";
  final firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: _screenSize.height / 3,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Text(
                "Enter room name",
                style: TextStyle(fontSize: 30, color: Colors.blue),
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
                  roomName = value;
                },
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text(
                      "Join",
                      style: TextStyle(
                          fontSize: _screenSize.width / 15,
                          color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        setState(() {
                          _loading = true;
                        });
                        final snapshot =
                            await firestore.collection(roomName).getDocuments();
                        if (snapshot.documents.length == 0) {
                          setState(() {
                            warning = "Room doesnt Exist";
                            _loading = false;
                          });
                        } else {
                          globals.admin = false;
                          globals.roomname = roomName;
                          DocumentSnapshot doc = await firestore
                              .collection(roomName)
                              .document("letter")
                              .get();
                          globals.firstLetter = doc['letter'];
                          print(globals.firstLetter);
                          Navigator.pop(context);
                        }
                      }
                    },
                    color: Colors.blue,
                  ),
                  Spacer(),
                  (_loading) ? CircularProgressIndicator() : Container(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              (warning != null)
                  ? Text(
                      warning,
                      style: TextStyle(color: Colors.red, fontSize: 32),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class CreateRoom extends StatefulWidget {
  String letter = "";

  CreateRoom({this.letter});

  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final _key = GlobalKey<FormState>();
  int _state = 0;
  String roomName;
  String warning;
  final firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: _screenSize.height / 3,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Text(
                "Enter room name",
                style: TextStyle(fontSize: 21, color: Colors.blue),
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
                  roomName = value;
                },
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text(
                      "Create",
                      style: TextStyle(
                          fontSize: _screenSize.width / 15,
                          color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        setState(() {
                          _state = 1;
                        });
                        final check =
                            await firestore.collection(roomName).getDocuments();
                        if (check.documents.length > 0) {
                          setState(() {
                            warning = "Already Exists";
                            _state = 0;
                          });
                          return;
                        }
                        globals.roomname = roomName;
                        await firestore
                            .collection(roomName)
                            .document("letter")
                            .setData({'letter': widget.letter, 'submit': 0});

                        setState(() {
                          _state = 2;
                        });
                        globals.firstLetter = widget.letter;
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.blue,
                  ),
                  Spacer(),
                  Builder(builder: (context) {
                    if (_state == 1) {
                      return CircularProgressIndicator();
                    } else if (_state == 2) {
                      globals.admin = true;
                      return Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 48,
                      );
                    }
                    return Container();
                  })
                ],
              ),
              Spacer(),
              (warning != null)
                  ? Text(
                      warning,
                      style: TextStyle(color: Colors.red, fontSize: 32),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
