import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'globals.dart' as global;
import 'animated_button.dart';

class Entry extends StatefulWidget {
  final Function onTap;

  Entry({this.onTap});

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  Key _key = GlobalKey<FormState>();
  var _currentData = new global.DataEntry();

  @override
  Widget build(BuildContext context) {
    return Form(
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
                      _currentData.name = value;
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
                      _currentData.place = value;
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
                              setState(() {
                                global.loading = !global.loading;
                                widget.onTap();
                              });

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
