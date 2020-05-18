import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'globals.dart';

class Entry extends StatefulWidget {
  final Function onTap;
  final DataEntry entry;

  Entry({this.onTap, this.entry});

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    GlobalState global = Provider.of<GlobalState>(context);
    var screenSize = MediaQuery.of(context).size;
    return Form(
      key: _key,
      child: Container(
        height: screenSize.height * 0.4,
        width: screenSize.width,
        margin: EdgeInsets.only(top: 30, left: 10,right: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 150,
                    child: TextFormField(
                      onSaved: (value) {
                        widget.entry.name = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Name", border: InputBorder.none),
                    ),
                  ),
                ),
                Spacer(),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 150,
                    child: TextFormField(
                      onSaved: (value) {
                        widget.entry.place = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Place",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(15)),
            Row(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 150,
                    child: TextFormField(
                      onSaved: (value) {
                        widget.entry.animal = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Animal", border: InputBorder.none),
                    ),
                  ),
                ),
                Spacer(),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 150,
                    child: TextFormField(
                      onSaved: (value) {
                        widget.entry.thing = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Thing",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
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
//                              if (widget.entry.name == "" && widget.entry.place == "") {
//                                widget.entry;
//                              }
                              _key.currentState.save();
                              _key.currentState.reset();
                              setState(() {
//                                global.data.add(global.currentData);
                                global.loading = !global.loading;
                              });
                              widget.onTap();
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
