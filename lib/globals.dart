import 'dart:math';
import 'package:flutter/cupertino.dart';

String randomLetter() => String.fromCharCode(Random().nextInt(26) + 65);
String roomname;

class GlobalState with ChangeNotifier {
  bool _loading;
  List<String> _letters;
  List<DataEntry> _dataEntryList;
  String _name;

  bool get loading => _loading;
  List<String> get letters => _letters;
  List<DataEntry> get data => _dataEntryList;
  String get name => _name;

  set name(String value){
    _name = value;
    notifyListeners();
  }
  set loading(bool value) {
    _loading = value;
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

  GlobalState(this._loading, this._letters, this._dataEntryList,this._name);
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
