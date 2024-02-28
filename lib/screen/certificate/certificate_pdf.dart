import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/pdf_controller.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart' ;

class PdfViewScreen extends StatelessWidget {
  final String pdfUrl; // Provide the PDF URL here

  const PdfViewScreen({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfViewController>(
      init: PdfViewController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text('Certificate PDF')),
          body: Center(
            child: PDFView(
              filePath: pdfUrl,
              onError: (error) {
                print('Error loading PDF: $error');
              },
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     controller.downloadPdf(pdfUrl);
          //   },
          //   child: Icon(Icons.download),
          // ),
        );
      },
    );
  }
}