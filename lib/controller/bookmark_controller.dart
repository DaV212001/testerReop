import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mss_e_learning/service/bookmark_services.dart';
import 'package:path_provider/path_provider.dart';
import '../model/bookmark.dart';
import '../model/certificate.dart';
import '../model/error_data.dart';

import '../util/api_call_status.dart';
import '../util/error_util.dart';
class BookMarkController extends GetxController {
  var bookmarks = <BookMark>[].obs;
  var isLoading = true.obs;
  var currentPage = 1; // Initialize with page 1
  var hasMorePages = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookMarks();
  }
  final errorData = ErrorData(title: "", body: "", image: "").obs;
  final status = ApiCallStatus.holding.obs;


  Future<String> downloadPdf(Certificates certificate) async {
    try {
      final response = await get(Uri.parse(certificate.url));
      final dir = await getTemporaryDirectory(); // Use cache directory
      final file = File('${dir.path}/certificate.pdf');
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    } catch (e) {
      print('Error downloading PDF: $e');
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Error downloading certificate, please try again.')));
      return ''; // Return an empty path if download fails
    }
  }

String statusS = '';

  Future<void> fetchBookMarks() async {
    try {
      status.value = ApiCallStatus.loading;

      final certs = await BookMarkServices.fetchBookmarks(currentPage);
      if (certs[1]&certs[0].isEmpty) {
        print('emptyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
        hasMorePages.value = false;// No more pages
        status.value = ApiCallStatus.success;
        return;
      } else {
        bookmarks.addAll(certs[0]);
        currentPage++;
      }
      status.value = ApiCallStatus.success;
    } on Exception catch (fetchError) {
      status.value = ApiCallStatus.error;
      errorData.value = ErrorUtil.getErrorData(fetchError.toString());
      statusS = 'error';
    }
  }
}
