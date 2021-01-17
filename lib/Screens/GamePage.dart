import 'package:flutter/material.dart';
import 'package:nameplace/Functions/Animations.dart';
import 'package:nameplace/Models/User.dart';
import 'package:nameplace/Screens/SideDrawer.dart';
import 'package:nameplace/global.dart';
import 'package:provider/provider.dart';

import 'Login.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    letter =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    letter.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    Game gamedata = Provider.of<Game>(context);
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: SideDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.dehaze,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: [
          TextButton.icon(
              onPressed: () {
                name = "";
                gamedata.room = "";
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              },
              icon: Icon(Icons.exit_to_app),
              label: Text("Exit"))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Animations.newletter(randomLetter(), context);
            },
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(letter),
              child: Material(
                elevation: 20,
                shape: CircleBorder(),
                color: (gamedata.letter == "-1")
                    ? Colors.redAccent
                    : Colors.lightGreen,
                child: Container(
                  alignment: Alignment.center,
                  height: _size.height * 0.13,
                  child: (gamedata.letter != "-1")
                      ? Text(
                          gamedata.letter,
                          style: TextStyle(fontSize: 54, color: Colors.white),
                        )
                      : Container(),
                ),
              ),
            ),
          ),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
