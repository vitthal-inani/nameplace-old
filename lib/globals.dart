import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'dart:collection';

String randomLetter() => String.fromCharCode(Random().nextInt(26) + 65);

class GlobalState with ChangeNotifier {
  bool _loading;
  List<String> _letters;
  List<DataEntry> _dataEntryList;

  bool get loading => _loading;
  List<String> get letters => _letters;
  List<DataEntry> get data => _dataEntryList;

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

  GlobalState(this._loading, this._letters, this._dataEntryList);
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
