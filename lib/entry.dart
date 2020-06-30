import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'globals.dart' as globals;
import 'databaseRef.dart';

class Entry extends StatefulWidget {
  final Function onTapSubmit;
  final Function onTapNext;
  final globals.DataEntry entry;

  Entry({this.onTapSubmit, this.onTapNext, this.entry});

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    submission(context, submit);
  }

  void submit(globals.GlobalState global) async {
    DocumentSnapshot docs = await Firestore.instance
        .collection(globals.roomname)
        .document('letter')
        .get();
    if (docs.data['submit'] == 1) {
      return;
    }
    _key.currentState.save();
    _key.currentState.reset();
    setState(() {
      global.loading = !global.loading;
    });
    widget.onTapSubmit();
    addEntry(context);
  }

  @override
  Widget build(BuildContext context) {
    globals.GlobalState global = Provider.of<globals.GlobalState>(context);
    var screenSize = MediaQuery.of(context).size;
    return Form(
      key: _key,
      child: Container(
        height: screenSize.height * 0.3,
        width: screenSize.width,
        margin: EdgeInsets.only(top: 30, bottom: 40, left: 10, right: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IgnorePointer(
              ignoring: global.wait,
              child: Row(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: screenSize.height / 21,
                      width: screenSize.width / 2.88,
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
                      height: screenSize.height / 21,
                      width: screenSize.width / 2.88,
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
            ),
            Spacer(),
            IgnorePointer(
              ignoring: global.wait,
              child: Row(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: screenSize.height / 21,
                      width: screenSize.width / 2.88,
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
                      height: screenSize.height / 21,
                      width: screenSize.width / 2.88,
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
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (globals.admin)
                      ? Container(
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(top: 10),
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
                                  });
                                  widget.onTapNext();
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Next",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )),
                          ))
                      : Container(),
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
                              globals.currentstate = 1;
                              submit(global);
                              Firestore.instance
                                  .collection(globals.roomname)
                                  .document('letter')
                                  .updateData({'submit': 1});
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
