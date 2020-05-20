import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'package:provider/provider.dart';

final databaseRef = Firestore.instance;

void addEntry(BuildContext context) {
  final global = Provider.of<globals.GlobalState>(context, listen: false);
  databaseRef.collection(globals.roomname).document(global.name).setData(({
        'name': global.data.last.name,
        'place': global.data.last.place,
        'animal': global.data.last.animal,
        'thing': global.data.last.thing
      }));
}

void getLetter(BuildContext context, Function func) {
  final global = Provider.of<globals.GlobalState>(context, listen: false);
  DocumentReference docref =
      databaseRef.collection(globals.roomname).document("letter");
  docref.snapshots().listen((event) {
    print(event['letter']);
    func(event['letter'], global);
  });
}

void Submission(BuildContext context, Function func) {
  print("1");
  final global = Provider.of<globals.GlobalState>(context, listen: false);
  DocumentReference doc =
      databaseRef.collection(globals.roomname).document('letter');
  doc.snapshots().listen((event) {
    print(event['submit']);
    if (event['submit'] == 1) {
      func(global);
    }
  });
}
