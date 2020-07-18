import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/downloadPage.dart';
import 'package:firestore/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Page"),
      ),
      body: StreamBuilder(
        stream: firestore.collection("books").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrange,
            ));
          } else {
            return ListView.separated(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                String items = snapshot.data.documents[index]['name'];
                return Card(
                  child: ListTile(
                      leading: Text(snapshot.data.documents[index]['number']),
                      title: Text(items),
                      onTap: () {
                        if (snapshot.data.documents[index]['link'] == "") {
                          Fluttertoast.showToast(
                              msg: "No file found on server",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: DarkMode.darkMode
                                  ? Colors.white
                                  : Colors.black,
                              textColor: DarkMode.darkMode
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 16.0);
                        } else
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DownloadPage(
                                appbarNumber: snapshot.data.documents[index]
                                    ['number'],
                                filename: snapshot.data.documents[index]
                                    ['name'],
                                url: snapshot.data.documents[index]['link'],
                                appbarName: snapshot.data.documents[index]
                                    ['name'],
                              ),
                            ),
                          );
                      }),
                );
              },
              separatorBuilder: (context, index) => Container(
                height: 5,
                color: Colors.white,
                child: Center(child: Text("")),
              ),
            );
          }
        },
      ),
    );
  }
}
