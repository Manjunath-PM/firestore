import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

import 'downloadPage.dart';
import 'values.dart';

class ListPage1 extends StatefulWidget {
  var collection;
  var appBarname;
  String a = "english";
  ListPage1({
    @required this.collection,
    @required this.appBarname,
    Key key,
  }) : super(key: key);
  @override
  _ListPage1State createState() => _ListPage1State();
}

class _ListPage1State extends State<ListPage1> {
  Firestore firestore = Firestore.instance;
  bool appnameCheck = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.appBarname == '' || widget.appBarname == null) {
      setState(() {
        appnameCheck = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkMode.darkMode ? primary_Grey : primaryOrange,
      body: StreamBuilder(
          stream: firestore.collection(widget.collection).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Loading....",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          appnameCheck ? widget.appBarname : '***************',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 20,
                      ),
                      decoration: BoxDecoration(
                          color: DarkMode.darkMode
                              ? primary_darkMode
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          )),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: InkWell(
                              splashColor: primaryGreen,
                              child: Card(
                                color: DarkMode.darkMode
                                    ? primary_Grey
                                    : Colors.white,
                                shadowColor: Colors.black,
                                child: Center(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      child: Text(
                                        snapshot.data.documents[index]
                                            ["number"],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      radius: 25,
                                    ),
                                    title: Text(
                                      snapshot.data.documents[index]["name"],
                                      style: TextStyle(
                                        color: DarkMode.darkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (snapshot.data.documents[index]["link"] ==
                                    '') {
                                  Fluttertoast.showToast(
                                      msg: "Link not available",
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
                                } else if (snapshot.data.documents[index]
                                        ["link"] ==
                                    null) {
                                  Fluttertoast.showToast(
                                      msg: "path not available",
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
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DownloadPage(
                                            appbarNumber: snapshot.data
                                                .documents[index]['number'],
                                            filename: snapshot
                                                .data.documents[index]['name'],
                                            url: snapshot.data.documents[index]
                                                ['link'],
                                            appbarName: snapshot
                                                .data.documents[index]['name'],
                                          )));
                                }
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          if (index != 0 && index % 5 == 0 || index == 0) {
                            return Container(
//                              height: 50,
//                              color: DarkMode.darkMode
//                                  ? primary_Grey
//                                  : Colors.white,
//                              child: Text("Advertisement"),
                                );
                          }

                          return Container();
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
