import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/certificate_controller.dart';
import 'package:mss_e_learning/screen/certificate/certificate_pdf.dart';
import '../../model/certificate.dart';

class CertificateCard extends StatefulWidget {
  final Certificates certificate;
  const CertificateCard({super.key, required this.certificate});

  @override
  State<CertificateCard> createState() => _CertificateCardState();
}

class _CertificateCardState extends State<CertificateCard> {

  CertificateController controller = Get.put(CertificateController());
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(widget.certificate.subcategory.name),
        trailing: loading? const CircularProgressIndicator():IconButton(
          icon: const Icon(Icons.download),
          onPressed: () async {
            setState(() {
              loading = true;
            });
            var localFilePath = await controller.downloadPdf(widget.certificate);
            setState(() {
              loading = false;
            });
            Get.to(()=>PdfViewScreen(pdfUrl: localFilePath));
          },
        ),
      ),
    );
  }
}
