import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nameplace/entry.dart';
import 'package:provider/provider.dart';
import 'globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'databaseRef.dart';

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
    currentData = DataEntry();
    _controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    _controller.value = 1;
  }

  void startTimer(GlobalState global) async {
    global.addDataEntry(currentData);
    currentData = DataEntry();
    print(global.data);

    await _controller.animateTo(0,
        duration: Duration(milliseconds: 900), curve: Curves.easeIn);
    var timer = Timer(Duration(milliseconds: 20), () {
      getRandom(global);
      global.loading = !global.loading;
      return;
    });
  }

  void getRandom(GlobalState global) {
    var randomAlpha = randomLetter();
    while (global.letters.contains(randomAlpha)) {
      randomAlpha = randomLetter();
    }

    global.addLetter(randomAlpha);

    setState(() {
      _controller.value = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var global = Provider.of<GlobalState>(context);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.blue,
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                startTimer(global);
              },
              child: Container(
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
                    onTap: () async {
                      global.loading = true;
                      startTimer(global);
                      addEntry(context);
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenSize.width / 6.3,
                          child: Center(
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 6.3,
                          child: Center(
                            child: Text(
                              "Place",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 6.3,
                          child: Center(
                            child: Text(
                              "Animal",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 6.3,
                          child: Center(
                            child: Text(
                              "Thing",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 6.3,
                          child: Center(
                            child: Text(
                              "Score",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
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
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.symmetric(vertical: BorderSide(color: Colors.black))
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: screenSize.width / 6.3,
                                    child: Center(
                                      child: Text(
                                        global.data[index].name,
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width / 6.3,
                                    child: Center(
                                      child: Text(
                                        global.data[index].place,
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width / 6.3,
                                    child: Center(
                                      child: Text(
                                        global.data[index].animal,
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width / 6.3,
                                    child: Center(
                                      child: Text(
                                        global.data[index].thing,
                                        style: TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width / 6.3,
                                    child: Center(
                                      child: Text(
                                        "Name",
                                        style: TextStyle(fontSize: 19),
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
                            );
                          }))
                ],
              ),
            ),
          ],
        ));
  }
}
