import 'package:firestore/firestore.dart';
import 'package:firestore/first_Puc_text_books.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void nextPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => FirstPucTextBooks()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore demo"),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          onPressed: nextPage,
          child: Text(
            "open",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
