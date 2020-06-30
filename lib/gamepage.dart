import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nameplace/entry.dart';
import 'package:provider/provider.dart';
import 'Players.dart';
import 'globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'databaseRef.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  DataEntry currentData;
  final databaseRef = Firestore.instance;

  @override
  void initState() {
    super.initState();
    if (!admin) {
      getLetter(context, nonAdmin);
    }
    currentData = DataEntry();
    _controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    _controller.value = 1;
  }

  void getRandom(GlobalState global) {
    var randomAlpha = randomLetter();
    while (global.letters.contains(randomAlpha)) {
      randomAlpha = randomLetter();
    }
    databaseRef
        .collection(roomname)
        .document("letter")
        .setData({'letter': randomAlpha, 'submit': 0});
    global.addLetter(randomAlpha);
    global.wait = false;
    setState(() {
      _controller.value = 1;
    });
  }

  void startTimer(GlobalState global) async {
    currentData = DataEntry();
    await _controller.animateTo(0,
        duration: Duration(seconds: 2), curve: Curves.easeInOut);
    var timer = Timer(Duration(milliseconds: 20), () {
      getRandom(global);
      setState(() {
        global.loading = !global.loading;
      });
      return;
    });
  }

  void nonAdmin(String alpha, GlobalState global) async {
    currentData = DataEntry();
    await _controller.animateTo(0,
        duration: Duration(seconds: 2), curve: Curves.easeInOut);
    global.addLetter(alpha);
    global.wait = false;
    setState(() {
      _controller.value = 1.00;
    });
    global.loading = !global.loading;
  }

  @override
  Widget build(BuildContext context) {
    var global = Provider.of<GlobalState>(context);
    var screenSize = MediaQuery.of(context).size;
    final _key = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _key,
        appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                _key.currentState.openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Text("Players"),
            )),
        drawer: Drawer(
          child: OtherPlayer(),
        ),
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.blue,
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: screenSize.height * 0.20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "LETTER : " + global.letters.last,
                        style: TextStyle(color: Colors.white, fontSize: 48),
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                    width: screenSize.width,
                    child: FractionallySizedBox(
                      heightFactor: 1,
                      widthFactor: _controller.value,
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.redAccent,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              height: screenSize.height * 0.78,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Column(
                children: [
                  Entry(
                    entry: currentData,
                    onTapSubmit: () {
                      global.loading = true;
                      global.addDataEntry(currentData);
                      setState(() {
                        global.wait = true;
                      });
                    },
                    onTapNext: () {
                      global.loading = !global.loading;
                      startTimer(global);
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black,width: 0.5)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenSize.width / 6.3,
                          child: Center(
                            child: Text(
                              "Name",
                              style: GoogleFonts.bebasNeue(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 6.3,
                          child: Center(
                            child: Text(
                              "Place",
                              style: GoogleFonts.bebasNeue(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 6.3,
                          child: Center(
                            child: Text(
                              "Animal",
                              style: GoogleFonts.bebasNeue(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 6.3,
                          child: Center(
                            child: Text(
                              "Thing",
                              style: GoogleFonts.bebasNeue(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 6.3,
                          child: Center(
                            child: Text(
                              "Score",
                              style: GoogleFonts.bebasNeue(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: screenSize.height * 0.20,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: ListView.builder(
                          itemCount: global.data.length,
                          itemBuilder: (context, index) {
                            return Material(
                              elevation: (index % 2 == 0)?5:0,
                              color: (index % 2 == 1)?Colors.grey.withOpacity(0.4):Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: Colors.black))),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: screenSize.width / 6.3,
                                      child: Center(
                                        child: Text(
                                          global.data[index].name,
                                          style: TextStyle(fontSize: 17),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width / 6.3,
                                      child: Center(
                                        child: Text(
                                          global.data[index].place,
                                          style: TextStyle(fontSize: 17),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width / 6.3,
                                      child: Center(
                                        child: Text(
                                          global.data[index].animal,
                                          style: TextStyle(fontSize: 17),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width / 6.3,
                                      child: Center(
                                        child: Text(
                                          global.data[index].thing,
                                          style: TextStyle(fontSize: 17),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width / 6.3,
                                      child: Center(
                                        child: Text(
                                          "Name",
                                          style:
                                              GoogleFonts.tajawal(fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 36,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }))
                ],
              ),
            ),
          ],
        ));
  }
}
