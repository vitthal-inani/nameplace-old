import 'package:flutter/material.dart';
import 'databaseRef.dart';

class OtherPlayer extends StatefulWidget {
  @override
  _OtherPlayerState createState() => _OtherPlayerState();
}

class _OtherPlayerState extends State<OtherPlayer> {
  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    return Material(
      child: Column(
        children: [
          Spacer(),
          Container(
            height: 40,
            child: Text(
              "Friends Playing",
              style: TextStyle(fontSize: 24),
            ),
            margin: EdgeInsets.only(bottom: 10),
          ),
          Spacer(),
          FutureBuilder(
              future: getPlayerData(context),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                      height: 30, width: 30, child: LinearProgressIndicator());
                }
                return Container(
                  height: _screensize.height * 0.7,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      title: Text("Answers"),
                                      content: DataTable(
                                        columns: [
                                          DataColumn(label: Text("")),
                                          DataColumn(label: Text(""))
                                        ],
                                        rows: [
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Text(
                                                  "Name",
                                                  style: TextStyle(
                                                      fontSize: 21,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ),
                                              DataCell(Text(
                                                snapshot
                                                    .data[index].data['name'],
                                                style: TextStyle(
                                                  fontSize: 21,
                                                ),
                                              ))
                                            ],
                                          ),
                                          DataRow(cells: [
                                            DataCell(Text(
                                              "Place",
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  fontStyle: FontStyle.italic),
                                            )),
                                            DataCell(Text(
                                              snapshot
                                                  .data[index].data['place'],
                                              style: TextStyle(
                                                fontSize: 21,
                                              ),
                                            ))
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text(
                                              "Animal",
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  fontStyle: FontStyle.italic),
                                            )),
                                            DataCell(Text(
                                              snapshot
                                                  .data[index].data['animal'],
                                              style: TextStyle(
                                                fontSize: 21,
                                              ),
                                            ))
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text(
                                              "Thing",
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  fontStyle: FontStyle.italic),
                                            )),
                                            DataCell(Text(
                                              snapshot
                                                  .data[index].data['thing'],
                                              style: TextStyle(
                                                fontSize: 21,
                                              ),
                                            ))
                                          ]),
                                        ],
                                      ));
                                });
                          },
                          child: Card(
                            color: Colors.blue,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                snapshot.data[index].documentID,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }
}
