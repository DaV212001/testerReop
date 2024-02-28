import 'package:flutter/material.dart';

import '../../controller/certificate_controller.dart';
import 'package:get/get.dart';

import '../../widget/certificate/certificate_card.dart';

class CertificatesListScreen extends StatelessWidget {
  final CertificateController certificateController = Get.put(CertificateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Certificates')),
      body: Obx(() {
        if (certificateController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: certificateController.certificates.length + 1,
            itemBuilder: (context, index) {
              if (index < certificateController.certificates.length) {
                final certificate = certificateController.certificates[index];
                return CertificateCard(certificate: certificate);
              } else if (certificateController.hasMorePages.value) {
                // Show a loading indicator or button to load more
                return Center(child: CircularProgressIndicator());
              } else {
                // No more pages
                return SizedBox.shrink();
              }
            },
          );
        }
      }),
    );
  }
}
