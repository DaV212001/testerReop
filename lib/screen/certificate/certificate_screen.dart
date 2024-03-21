import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mss_e_learning/layout/password/header_image_and_text.dart';
import '../../controller/certificate_controller.dart';
import 'package:get/get.dart';
import '../../widget/certificate/certificate_card.dart';
import '../../widget/load_more_button.dart';



class CertificatesListScreen extends StatefulWidget {
  const CertificatesListScreen({super.key});

  @override
  State<CertificatesListScreen> createState() => _CertificatesListScreenState();
}

class _CertificatesListScreenState extends State<CertificatesListScreen> {
  final CertificateController certificateController =
  Get.put(CertificateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          title: Text(
            'Certificates',
            style: FlutterFlowTheme.of(context)
                .headlineSmall
                .override(fontFamily: 'Poppins'),
          )),
      body: Obx(() {
        if (certificateController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (certificateController.certificates.isEmpty) {
          return Center(
              child: HeaderImageAndText(
                showbackButton: false,
                imagePath: 'assets/images/illustrations/no_certificates.svg',
                headerText: 'No certificates yet',
                color: FlutterFlowTheme.of(context).primaryText,
              ));
        } else {
          return RefreshIndicator(
            color: Theme.of(context).primaryColor,
            displacement: MediaQuery.of(context).size.height * 0.1,
            onRefresh: () {
              certificateController.certificates.clear();
              certificateController.currentPage = 1;
              return certificateController.fetchCertificates();
            },
            child: ListView.builder(
              itemCount: certificateController.certificates.length + 1,
              itemBuilder: (context, index) {
                if (index < certificateController.certificates.length) {
                  final certificate = certificateController.certificates[index];
                  return CertificateCard(certificate: certificate);
                } else if (certificateController.hasMorePages.value) {
                  // Show a loading indicator or button to load more
                  return LoadMoreButton(
                      onTap:(){
                        certificateController.fetchCertificates();
                      }
                  );
                } else {
                  // No more pages
                  return SizedBox.shrink();
                }
              },
            ),
          );
        }
      }),
    );
  }
}
