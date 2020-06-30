import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gamepage.dart';

String randomLetter() => String.fromCharCode(Random().nextInt(26) + 65);
String roomname = "";
String firstLetter=" ";
bool admin = false, submitted=false;
var currentstate = 0;
String name='';

class GlobalState with ChangeNotifier {
  bool _loading;
  List<String> _letters;
  List<DataEntry> _dataEntryList;
  bool _wait;

  bool get loading => _loading;
  List<String> get letters => _letters;
  List<DataEntry> get data => _dataEntryList;
  bool get wait => _wait;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
  set wait(bool value){
    _wait = value;
    notifyListeners();
  }

  addLetter(String letter) {
    _letters.add(letter);
    notifyListeners();
  }

  addDataEntry(DataEntry entry) {
    _dataEntryList.add(entry);
    notifyListeners();
  }

  GlobalState(this._loading, this._letters, this._dataEntryList,this._wait);
}

class DataEntry {
  String name, place, animal, thing;

  DataEntry({
    this.name = "",
    this.place = "",
    this.animal = "",
    this.thing = "",
  });

  @override
  String toString() {
    return '$name $place $animal $thing';
  }
}
