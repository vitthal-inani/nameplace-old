import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nameplace/entry.dart';
import 'package:provider/provider.dart';
import 'globals.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _reset = true;

  DataEntry currentData;

  @override
  void initState() {
    super.initState();
    currentData = DataEntry();
    _controller = AnimationController(duration: Duration(milliseconds: 900), vsync: this)
      ..addListener(() {
        setState(() {});
      });
    _controller.value = 0;
  }

  void startTimer(GlobalState global) async {
    global.addDataEntry(currentData);
    currentData = DataEntry();
    print(global.data);

    await _controller.animateTo(1, duration: Duration(milliseconds: 900), curve: Curves.easeIn);
    var timer = Timer(Duration(seconds: 1), () {
      getRandom(global);
      setState(() {
        global.loading = !global.loading;
      });
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
      _controller.value = 0;
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
                      topRight: Radius.circular(30), topLeft: Radius.circular(30))),
              child: Column(
                children: [
                  Entry(
                    entry: currentData,
                    onTap: () {
                      startTimer(global);
                    },
                  ),
                  Container(
                    width: screenSize.width,
                    height: 200,
//                    child: ListView.builder(
//                        itemCount: global.data.length,
//                        itemBuilder: (context,index){
//                          return Text(global.data[index].name + " "+ index.toString());
//                        }),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
