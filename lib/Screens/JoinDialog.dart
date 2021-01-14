import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nameplace/Models/User.dart';
import 'package:provider/provider.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {
  String roomname;
  final firestore = FirebaseFirestore.instance;
  bool check = false;
  String warning = "Room";
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery
        .of(context)
        .size;
    Game gamedata = Provider.of<Game>(context);
    return Dialog(
      child: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _size.height * 0.05, horizontal: _size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Text(
                    "Join",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              TextFormField(
                decoration: InputDecoration(hintText: "Room Name"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
                onSaved: (value) {
                  roomname = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Join",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        setState(() {
                          check = true;
                        });
                      }
                      final snapshot =
                      await firestore.collection(roomname).get();
                      if (snapshot.docs.length == 0) {
                        setState(() {
                          warning = "Room doesn't exist";
                          check = false;
                        });
                      } else {
                        gamedata.room = roomname;
                        await firestore.collection(roomname).doc('letter')
                            .get()
                            .then((value) {
                          gamedata.letter = value.data()['letter'];
                        });
                        print(gamedata.letter);
                        gamedata.letter = "-1";
                        Navigator.pop(context);
                      }
                    },
                  ),
                  (check) ? CircularProgressIndicator() : Text(warning),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}