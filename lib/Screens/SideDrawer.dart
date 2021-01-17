import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nameplace/Models/User.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  var firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    Game gamedata = Provider.of<Game>(context);
    return Drawer(
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: _size.height * 0.05, horizontal: _size.width * 0.05),
        child: FutureBuilder(
          future: firestore.collection(gamedata.room).get(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot a = snapshot.data;
              return ListView.builder(
                itemCount: a.docs.length,
                itemBuilder: (context, index) {
                  if (a.docs[index].id != "letter")
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: ExpansionTile(
                        title: Text(a.docs[index].id),
                        collapsedBackgroundColor: Colors.white38,
                        backgroundColor: Colors.white38,
                        children: [
                          Text(a.docs[index].data().toString()),
                        ],
                      ),
                    );
                  return Container();
                },
              );
            } else
              return Center(child: LinearProgressIndicator());
          },
        ),
      ),
    );
  }
}
