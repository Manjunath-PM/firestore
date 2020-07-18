import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore/firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'values.dart';
import 'List_page.dart';

class FirstPucTextBooks extends StatefulWidget {
  @override
  _FirstPucTextBooksState createState() => _FirstPucTextBooksState();
}

class _FirstPucTextBooksState extends State<FirstPucTextBooks> {
  Firestore firestore = Firestore.instance;
  bool issort = false;
  List<Map> firstPucTextBooks;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkMode.darkMode ? primary_Grey : primaryOrange,
      body: Column(
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
                  'First PU Text Books',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
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
                  color: DarkMode.darkMode ? primary_darkMode : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream: firestore.collection("books").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: DarkMode.darkMode
                                  ? primary_Grey
                                  : Colors.white,
                            ),
                            height: 90,
                            child: InkWell(
                              child: Card(
                                color: DarkMode.darkMode
                                    ? primary_Grey
                                    : Colors.white,
                                child: Center(
                                  child: ListTile(
                                      contentPadding:
                                          EdgeInsets.only(left: 0, right: 30),
//                                    leading: Image.asset(
//                                      firstPucTextBooks[index]['iconpath'],
//                                      height: 100,
//                                      width: 100,
//                                    ),
                                      title: Text(
                                        snapshot.data.documents[index]["name"],
                                        style: TextStyle(
                                          color: DarkMode.darkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      onTap: () {
                                        if (snapshot.data.documents[index]
                                                ["path"] ==
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
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ListPage1(
                                              collection: snapshot.data
                                                  .documents[index]["path"],
                                              appBarname:
                                                  snapshot.data.documents[index]
                                                      ["appBarName"],
                                            ),
                                          ));
                                        }
                                      }),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          if (index != 0 && index == 1 ||
                              index == 7 ||
                              index == 13 ||
                              index == 19 ||
                              index == 25) {
                            return Container(
                              height: 100,
                              color: DarkMode.darkMode
                                  ? primary_Grey
                                  : Colors.white,
                              child: Center(child: Text("Advertisement")),
                            );
                          }

                          return Container();
                        },
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
