import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nameplace/Models/User.dart';
import 'package:nameplace/Screens/CreateDialog.dart' as cr;
import 'package:nameplace/Screens/GamePage.dart';
import 'package:nameplace/Screens/JoinDialog.dart';
import 'package:nameplace/global.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final firestore = FirebaseFirestore.instance;
  final _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    Game gamedata = Provider.of<Game>(context);
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Material(
          color: Colors.white,
          elevation: 10,
          child: Container(
            height: _size.height * 0.4,
            width: _size.width * 0.60,
            padding: EdgeInsets.symmetric(
                vertical: _size.height * 0.05, horizontal: _size.width * 0.05),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                    child: TextFormField(
                      validator: (inp) {
                        if (inp.isEmpty) {
                          return "Please enter a name";
                        }
                        return null;
                      },
                      onSaved: (inp) {
                        name = inp;
                      },
                      decoration: InputDecoration(
                        hintText: "Name",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      "Enter",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (gamedata.room.isNotEmpty) {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          await firestore
                              .collection(gamedata.room)
                              .doc(name)
                              .get()
                              .then((value) async {
                            if (value.exists)
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          Text("Name Already exists in the room"),
                                    );
                                  });
                            else {
                              print("Sahi hain");
                              await firestore
                                  .collection(gamedata.room)
                                  .doc(name)
                                  .set({
                                'name': '',
                                'place': '',
                                'animal': '',
                                'thing': '',
                                'score': ''
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GamePage()));
                            }
                          }).catchError((e) {
                            print("Sahi hain");
                          });
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Please join or create a room"),
                              );
                            });
                      }
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                    height: 5,
                  ),
                  Text(
                    "Room",
                    style: TextStyle(fontSize: 16),
                  ),
                  (gamedata.room.isEmpty)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              child: Text(
                                "Join",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Join(),
                                );
                              },
                            ),
                            ElevatedButton(
                              child: Text(
                                "Create",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                print("Create");
                                showDialog(
                                  context: context,
                                  builder: (context) => cr.Create(),
                                );
                              },
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(gamedata.room),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                gamedata.room = "";
                              },
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
