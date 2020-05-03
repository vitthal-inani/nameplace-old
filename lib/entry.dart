import 'package:flutter/material.dart';
import 'globals.dart' as global;

class Entry extends StatefulWidget {
  final Function onTap;

  Entry({this.onTap});

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Container(
        height: global.screenSize.height * 0.4,
        width: global.screenSize.width,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  child: TextFormField(
                    onSaved: (value) {
                      global.currentData.name = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Name",
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  child: TextFormField(
                    onSaved: (value) {
                      global.currentData.place = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Place",
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.all(15)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  child: TextFormField(
                    onSaved: (value) {
                      global.currentData.animal = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Animal",
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  child: TextFormField(
                    onSaved: (value) {
                      global.currentData.thing = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Thing",
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (global.loading) ? CircularProgressIndicator() : Container(),
                  Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(top: 20),
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green,
                        child: FlatButton.icon(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: Colors.green,
                            onPressed: () {
                              for (int i = 0; i < global.data.length; i++) {
                                print(global.data[i].name);
                              }
                              _key.currentState.save();
                              _key.currentState.reset();
                              setState(() {
                                global.data.add(global.currentData);
                                global.loading = !global.loading;
                                widget.onTap();
                              });
                              for (int i = 0; i < global.data.length; i++) {
                                print(global.data[i].name);
                              }
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            )),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
