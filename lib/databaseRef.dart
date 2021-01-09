import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'package:provider/provider.dart';

final databaseRef = FirebaseFirestore.instance;
void addEntry(BuildContext context) {
  final global = Provider.of<globals.GlobalState>(context, listen: false);
  final room = Provider.of<globals.RoomState>(context,listen: false);
  databaseRef.collection(room.roomname).doc(globals.name).set({
    'name': global.data.last.name,
    'place': global.data.last.place,
    'animal': global.data.last.animal,
    'thing': global.data.last.thing
  });
}

void getLetter(BuildContext context, Function func) {
  final global = Provider.of<globals.GlobalState>(context, listen: false);
  final room = Provider.of<globals.RoomState>(context,listen: false);
  DocumentReference docref =
      databaseRef.collection(room.roomname).doc("letter");
  docref.snapshots().listen((event) {
    if (event['letter'] != global.letters.last) {
      print(event['letter']);
      func(event['letter'], global);
    }
  });
}

void submission(BuildContext context, Function function) {
  final global = Provider.of<globals.GlobalState>(context, listen: false);
  final room = Provider.of<globals.RoomState>(context,listen: false);
  DocumentReference doc =
      databaseRef.collection(room.roomname).doc('letter');
  doc.snapshots().listen((event) {
    if (event['submit'] != globals.currentstate) {
      if (event['submit'] == 1) {
        function(global);
      }
      globals.currentstate = event['submit'];
    }
  });
}

Future<List> getPlayerData(BuildContext context) async {
  final room = Provider.of<globals.RoomState>(context,listen: false);
  QuerySnapshot req =
      await databaseRef.collection(room.roomname).get();
  List<DocumentSnapshot> docs = req.docs;
  docs.removeWhere((element) => (element.id == 'letter')||(element.id == globals.name) );
  return docs;
}
