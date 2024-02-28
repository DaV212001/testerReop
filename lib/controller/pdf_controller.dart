import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';


class PdfViewController extends GetxController {
  Future<String> downloadPdf(String certificate) async {
    try {
      final response = await get(Uri.parse(certificate));
      final dir = await getTemporaryDirectory(); // Use cache directory
      final file = File('${dir.path}/certificate.pdf');
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    } catch (e) {
      print('Error downloading PDF: $e');
      return ''; // Return an empty path if download fails
    }
  }
}