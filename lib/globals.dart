import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String randomLetter() => String.fromCharCode(Random().nextInt(26) + 65);
String firstLetter=" ";
bool admin = false, submitted=false;
var currentstate = 0;
String name='';

class RoomState with ChangeNotifier{
  String _room;
  String get roomname => _room;

  set roomname(String room){
    _room=room;
    notifyListeners();
  }
  RoomState(this._room);
}

class GlobalState with ChangeNotifier {
  int _loading;
  List<String> _letters;
  List<String> _adletters;
  List<DataEntry> _dataEntryList;
  bool _wait;

  int get loading => _loading;
  List<String> get letters => _letters;
  List<DataEntry> get data => _dataEntryList;
  bool get wait => _wait;
  List<String> get adletters => _adletters;

  set loading(int value) {
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
  addasLetter(String letter) {
    _adletters.add(letter);
    notifyListeners();
  }
  addDataEntry(DataEntry entry) {
    _dataEntryList.add(entry);
    notifyListeners();
  }

  GlobalState(this._loading, this._letters,this._adletters, this._dataEntryList,this._wait);
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
