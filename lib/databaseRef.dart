import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'package:provider/provider.dart';

final databaseRef = Firestore.instance;
void addEntry(BuildContext context) {
  final global = Provider.of<globals.GlobalState>(context, listen: false);
  databaseRef.collection(globals.roomname).document(global.name).setData({
    'name': global.data.last.name,
    'place': global.data.last.place,
    'animal': global.data.last.animal,
    'thing': global.data.last.thing
  });
}

void getLetter(BuildContext context, Function func) {
  final global = Provider.of<globals.GlobalState>(context, listen: false);
  DocumentReference docref =
      databaseRef.collection(globals.roomname).document("letter");
  docref.snapshots().listen((event) {
    if (event['letter'] != global.letters.last) {
      print(event['letter']);
      func(event['letter'], global);
    }
  });
}

void submission(BuildContext context, Function function) {
  final global = Provider.of<globals.GlobalState>(context, listen: false);
  DocumentReference doc =
      databaseRef.collection(globals.roomname).document('letter');
  doc.snapshots().listen((event) {
    if (event['submit'] != globals.currentstate) {
      print(event['submit'].toString() + " " + globals.currentstate.toString());
      if (event['submit'] == 1) {
        function(global);
      }
      globals.currentstate = event['submit'];
      print(globals.currentstate);
    }
  });
}

Future<List> getPlayerData() async {
  QuerySnapshot req =
      await databaseRef.collection(globals.roomname).getDocuments();
  List<DocumentSnapshot> docs = req.documents;
  docs.removeWhere((element) => element.documentID == 'letter');
  return docs;
}
