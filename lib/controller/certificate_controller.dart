import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import '../model/certificate.dart';
import '../service/certificate_service.dart'; // Import your CertificateServices

class CertificateController extends GetxController {
  var certificates = <Certificates>[].obs;
  var isLoading = true.obs;
  var currentPage = 1; // Initialize with page 1
  var hasMorePages = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCertificates();
  }
  Future<String> downloadPdf(Certificates certificate) async {
    try {
      final response = await get(Uri.parse(certificate.url));
      final dir = await getTemporaryDirectory(); // Use cache directory
      final file = File('${dir.path}/certificate.pdf');
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    } catch (e) {
      print('Error downloading PDF: $e');
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
              content: Text('Error downloading certificate, please try again.')
          )
      );
      return ''; // Return an empty path if download fails
    }
  }

  void fetchCertificates() async {
    try {
      final certs = await CertificateServices.fetchCertificates(currentPage);
      if (certs.isEmpty) {
        hasMorePages.value = false; // No more pages
      } else {
        certificates.addAll(certs);
        currentPage++; // Increment page for next fetch
      }
    }
    catch (e) {
      print('Error fetching certificates: $e');
    }
    finally {
      isLoading.value = false;
    }
  }
}
