import 'package:flutter/material.dart';

class Game extends ChangeNotifier {
  int _loading;
  User _data;
  String _room;
  String _letter;

  int get loading =>_loading;
  User get data => _data;
  String get room=>_room;
  String get letter=>_letter;

  set data(User inp){
    _data=inp;
    notifyListeners();
  }
  set loading(int inp){
    _loading=inp;
    notifyListeners();
  }
  set room(String inp){
    _room=inp;
    notifyListeners();
  }
  set letter(String inp){
    _letter=inp;
    notifyListeners();
  }

  Game(this._loading,this._room);
}

class User{
  String name, place, animal, thing;

  User({
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
