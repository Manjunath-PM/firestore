import 'dart:async';
import 'dart:io';

import 'PdfScreens/pdfView.dart';
import 'PdfScreens/pdfViewV7.dart';
import 'values.dart';
import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class DownloadPage extends StatefulWidget {
  String filename;
  String url;
  String appbarName;
  String appbarNumber;
  DownloadPage({
    Key key,
    @required this.filename,
    @required this.url,
    @required this.appbarName,
    @required this.appbarNumber,
  }) : super(key: key);
  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  var progresstring = "";
  bool downloading = false;
  static var path = "";
  bool alreadyDownloaded = false;
  bool fbNativeAdLoaded = true;
  ProgressDialog progressDialog;
  String downloadData = '';
  bool ifUrlPresent = true;
  Dio dio;
  bool cancelDownload = false;
  CancelToken cancelToken;

  @override
  void initState() {
    super.initState();
    checkFile();
    verifyFileurl();
  }

  Future<void> verifyFileurl() {
    String verifyurl = widget.url;
    if (verifyurl == '') {
      setState(() {
        ifUrlPresent = false;
      });
    }
  }

  Future<void> checkFile() async {
    String fileName = widget.filename;
    String dir = (await getApplicationDocumentsDirectory()).path;
    String savePath = '$dir/$fileName.pdf';
    bool abc =
        FileSystemEntity.typeSync(savePath) != FileSystemEntityType.notFound;
    if (abc == true) {
      setState(() {
        path = savePath;
        alreadyDownloaded = true;
      });
    }
  }

  Future<void> DownloadFile() async {
    try {
      var appDocDir = await getApplicationDocumentsDirectory();
      path = '${appDocDir.path}/${widget.filename}.pdf';
      dio = Dio();
      await dio.download(widget.url, path, cancelToken: cancelToken,
          onReceiveProgress: (rec, total) {
        print('rec:$rec, total:$total');
        var percentage = rec / total * 100;
        setState(() {
          downloading = true;
          progresstring = 'Downloading file : ${percentage.floor()}%';
          path = '${appDocDir.path}/${widget.filename}.pdf';
        });
      });
      setState(() {
        alreadyDownloaded = true;
        downloading = false;
        progressDialog.hide();
        Fluttertoast.showToast(
            msg: "Download completed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: DarkMode.darkMode ? Colors.white : Colors.black,
            textColor: DarkMode.darkMode ? Colors.black : Colors.white,
            fontSize: 16.0);
      });
    } catch (e) {
      if (e is DioError) {
        alreadyDownloaded = false;
        downloading = false;
        progressDialog.hide();

        Fluttertoast.showToast(
            msg: "Download failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: DarkMode.darkMode ? Colors.white : Colors.black,
            textColor: DarkMode.darkMode ? Colors.black : Colors.white,
            fontSize: 16.0);
      }
    }
  }

  Future<void> DeleteFile() async {
    String fileName = widget.filename;
    String dir = (await getApplicationDocumentsDirectory()).path;
    String savePath = '$dir/$fileName.pdf';
    File file = File(savePath);
    file.deleteSync(recursive: true);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget deleteButton = FlatButton(
      child: Text(
        "Delete",
        style: TextStyle(color: DarkMode.darkMode ? Colors.red : Colors.red),
      ),
      onPressed: () {
        DeleteFile();
        setState(() {
          alreadyDownloaded = false;
          downloading = false;
        });
        Fluttertoast.showToast(
            msg: ' "${widget.filename}" - Deleted',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: DarkMode.darkMode ? Colors.white : Colors.black,
            textColor: DarkMode.darkMode ? Colors.black : Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      },
    );
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: DarkMode.darkMode ? Colors.blue : Colors.blue),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: DarkMode.darkMode ? primary_Grey : Colors.white,
      title: Text(
        "Confirm 🚫 ",
        style:
            TextStyle(color: DarkMode.darkMode ? Colors.white : Colors.black),
      ),
      content: Text(
        "This action will delete\n\n \"${widget.appbarNumber}. ${widget.appbarName}\"\n",
        style:
            TextStyle(color: DarkMode.darkMode ? Colors.white : Colors.black),
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  width: 30,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${widget.appbarNumber}. ${widget.appbarName}',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: DarkMode.darkMode ? primary_darkMode : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: Column(
                children: <Widget>[
                  alreadyDownloaded
                      ? Container(
                          height: 135,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Text(
                                    'View Pdf',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryOrange,
                                        fontSize: 25),
                                  ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      showAlertDialog(context);
                                    },
                                  )
                                ],
                              ),
                              Container(
                                height: 70,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 160,
                                      child: RaisedButton(
                                          color: DarkMode.darkMode
                                              ? primary_Grey
                                              : primaryOrange,
                                          child: Text(
                                            'Advanced Mode',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PDFScreen(
                                                          path: path,
                                                          currentPage: 0,
                                                        )));
                                          }),
                                    ),
                                    Container(
                                      width: 160,
                                      child: RaisedButton(
                                          color: DarkMode.darkMode
                                              ? primary_Grey
                                              : primaryOrange,
                                          child: Text(
                                            'Normal Mode',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PDFScreenV7(
                                                          path,
                                                        )));
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Divider(
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(
                          height: 135,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                width: 200,
                                child: RaisedButton(
                                    color: DarkMode.darkMode
                                        ? primary_Grey
                                        : primaryOrange,
                                    child: Text(
                                      'Download File',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      DownloadFile();
                                      progressDialog = ProgressDialog(
                                        context,
                                        type: ProgressDialogType.Normal,
                                        isDismissible: false,
                                      );
                                      progressDialog.update(
                                          message: 'Downloading file',
                                          progressWidget: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor:
                                                      Colors.deepOrange,
                                                ),
                                                height: 30,
                                                width: 30,
                                              ),
                                            ],
                                          ));
                                      if (widget.url == '') {
                                        progressDialog.hide();
                                      } else {
                                        progressDialog.show();
                                      }
                                    }),
                              ),
                              downloading
                                  ? Text(
                                      '$progresstring',
                                      style: TextStyle(
                                          color: DarkMode.darkMode
                                              ? Colors.white
                                              : Colors.black),
                                    )
                                  : Text(''),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Divider(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
