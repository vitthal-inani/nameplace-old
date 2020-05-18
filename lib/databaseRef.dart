import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart';
import 'package:provider/provider.dart';

final databaseRef = Firestore.instance;

void addEntry(BuildContext context) async {
  final global = Provider.of<GlobalState>(context,listen: false);
  print("Hi");
  await databaseRef.collection("Uses").document(global.name).setData(({
        'name': global.data.last.name,
        'place': global.data.last.place,
        'animal': global.data.last.animal,
        'thing': global.data.last.thing
      }));
}
