import 'dart:math';
import 'package:flutter/cupertino.dart';

var randomLetter = String.fromCharCode(Random().nextInt(26) + 65);
List<String> letters = [randomLetter];
Size screenSize;
bool loading = false;
class DataEntry {
  String name, place, animal, thing;

  DataEntry({this.name, this.place, this.animal, this.thing});
}
List<DataEntry> data;