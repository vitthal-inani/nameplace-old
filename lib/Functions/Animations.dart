import 'package:flutter/material.dart';
import 'package:nameplace/Models/User.dart';
import 'package:nameplace/global.dart';
import 'package:provider/provider.dart';

class Animations {
  static newletter(String inpletter, BuildContext context) {
    Game gamedata = Provider.of<Game>(context,listen: false);
    letter.addListener(() {
      if (letter.value > 0.5) {
        gamedata.letter = inpletter;
        letter.stop();
        letter.forward();
      }
    });
    letter.value=0;
    letter.forward();
  }
}
