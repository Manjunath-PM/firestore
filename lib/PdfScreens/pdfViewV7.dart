import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PDFScreenV7 extends StatelessWidget {
  String pathPDF = "";
  PDFScreenV7(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("PDF View"),
      ),
      path: pathPDF,
    );
  }
}
