import 'pdfViewV7.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';

class PDFScreen extends StatefulWidget {
  final String path;
  int currentPage = 0;

  PDFScreen({
    Key key,
    @required this.path,
    @required this.currentPage,
  }) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int pages = 0;
  bool isReady = false;
  String errorMessage = '';
  static bool nightMode = false;
  static bool appBarNightMode = false;
  static bool rotation = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    if (DarkMode.darkMode == true) {
//      setState(() {
//        nightMode = true;
//      });
//    }
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("PDF View"),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: Text(
                  '${widget.currentPage + 1} / $pages',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              rotation
                  ? IconButton(
                      iconSize: 25,
                      icon: Icon(Icons.phone_android),
                      onPressed: () {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeRight,
                          DeviceOrientation.landscapeLeft,
                        ]);
                        setState(() {
                          rotation = false;
                        });
                      })
                  : IconButton(
                      iconSize: 25,
                      icon: Icon(Icons.screen_rotation),
                      onPressed: () {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                        ]);
                        setState(() {
                          rotation = true;
                        });
                      }),
              SizedBox(
                width: 10,
              ),
              nightMode
                  ? IconButton(
                      iconSize: 25,
                      icon: Icon(Icons.wb_sunny),
                      onPressed: () {
                        setState(() {
                          nightMode = false;
                          appBarNightMode = false;
                        });
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (BuildContext context) => PDFScreen(
                                    path: widget.path,
                                    currentPage: widget.currentPage,
                                  )),
                        );
                      },
                    )
                  : IconButton(
                      iconSize: 25,
                      icon: Icon(Icons.brightness_2),
                      onPressed: () {
                        setState(() {
                          nightMode = true;
                          appBarNightMode = true;
                        });
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => PDFScreen(
                                  path: widget.path,
                                  currentPage: widget.currentPage,
                                )));
                      },
                    )
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            swipeHorizontal: false,
            enableSwipe: true,
            nightMode: nightMode,
            autoSpacing: true,
            defaultPage: widget.currentPage,
            fitEachPage: false,
            pageFling: true,
            fitPolicy: FitPolicy.WIDTH,
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onPageChanged: (int page, int total) {
              print('page change: $page/$total');
              setState(() {
                widget.currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Advanced mode not available for your device'),
                          RaisedButton(
                              color: Colors.green,
                              child: Text(
                                'View in normal mode',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PDFScreenV7(
                                              widget.path,
                                            )));
                              })
                        ],
                      ),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
    );
  }
}
