import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import '../model/certificate.dart';
import '../service/certificate_service.dart'; // Import your CertificateServices
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../util/app_constants.dart';
class CertificateController extends GetxController {
  var certificates = <Certificates>[].obs;
  var isLoading = true.obs;
  var currentPage = 1; // Initialize with page 1
  var hasMorePages = true.obs;
  bool _isDownloading = false;
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
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Error downloading certificate, please try again.')));
      return ''; // Return an empty path if download fails
    }
  }

  Future<void> showCertificateDialog(
      BuildContext context, Certificates certificate) async {
    _isDownloading = false; // Reset the download state
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      left: 16,
                      right: 16,
                    ),
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppConstants.primary,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          certificate.url!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${certificate.testResult.subCategory!.name!} - ${certificate.testResult.level!.name}',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Rank: ${certificate.testResult.rank}',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: 'Poppins',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No. of Questions: ${certificate.testResult.noOfQuestions}',
                          style: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                                fontFamily: 'Poppins',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return ElevatedButton(
                                onPressed: () async {
                                  _isDownloading =
                                      true; // Set the download state to true
                                  setState(
                                      () {}); // Notify the widget to rebuild
                                  final filePath =
                                      await downloadPdf(certificate);
                                  if (filePath.isNotEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Certificate downloaded successfully'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Error downloading certificate, please try again.'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                  _isDownloading =
                                      false; // Reset the download state
                                  setState(
                                      () {}); // Notify the widget to rebuild
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    AppConstants.primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.white
                                        )),
                                child: _isDownloading
                                    ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                    :
                                    const Icon(
                                      FontAwesomeIcons.download,
                                      color: Colors.white,
                                    )
                                // Text(
                                //   'Download',
                                //   style: FlutterFlowTheme.of(context)
                                //       .titleSmall
                                //       .override(
                                //         fontFamily: 'Poppins',
                                //         color: FlutterFlowTheme.of(context)
                                //             .primaryText,
                                //       ),
                                // ),
                              );
                      },
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  Future<void> fetchCertificates() async {
    isLoading.value = true;
    try {
      final certs = await CertificateServices.fetchCertificates(currentPage);
      if (certs[1]) {
        print('here');
        hasMorePages.value = false; // No more pages
        return;
      } else {
        certificates.addAll(certs[0]);
        currentPage++;
      }
    } catch (e) {
      print('Error fetching certificates: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
