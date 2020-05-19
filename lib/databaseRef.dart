import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart';
import 'package:provider/provider.dart';

final databaseRef = Firestore.instance;

void addEntry(BuildContext context) {
  final global = Provider.of<GlobalState>(context,listen: false);
  databaseRef.collection(roomname).document(global.name).setData(({
        'name': global.data.last.name,
        'place': global.data.last.place,
        'animal': global.data.last.animal,
        'thing': global.data.last.thing
      }));
}
String getLetter(BuildContext context){
    final global = Provider.of<GlobalState>(context,listen: false);
    DocumentReference docref = databaseRef.collection(roomname).document("letter");
    docref.snapshots().listen((event) {
      print(event.data);
    });
}
