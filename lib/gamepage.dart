import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nameplace/entry.dart';
import 'globals.dart' as global;

class gamepage extends StatefulWidget {
  @override
  _gamepageState createState() => _gamepageState();
}

class _gamepageState extends State<gamepage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _reset = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    _controller.value = 0;
  }

  void startTimer() async {
    setState(() {
      _reset = true;
    });
    await _controller.animateTo(1,
        duration: Duration(milliseconds: 900), curve: Curves.easeIn);
    var timer = Timer(Duration(milliseconds: 0), () {
      getRandom();
      setState(() {
        global.loading = !global.loading;
      });
      return;
    });
  }

  void getRandom() {
    var randomalpha = String.fromCharCode(Random().nextInt(26) + 65);
    for (int i = 0; i < global.letters.length; i++) {
      if (randomalpha == global.letters[i]) {
        getRandom();
        return;
      }
    }
    global.letters.add(randomalpha);
    print(global.letters);
    setState(() {
      global.randomLetter = randomalpha;
      print(global.randomLetter);
      _controller.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    global.screenSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.blue,
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                startTimer();
              },
              child: Container(
                alignment: Alignment.center,
                height: global.screenSize.height * 0.20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "LETTER : " + global.randomLetter,
                          style: TextStyle(color: Colors.white, fontSize: 48),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: global.screenSize.width,
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
              height: global.screenSize.height * 0.78,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Column(
                children: [
                  Entry(
                    onTap: () {
                      startTimer();
                    },
                  ),
                  Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}