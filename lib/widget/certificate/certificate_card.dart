import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/certificate_controller.dart';
import '../../model/certificate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../util/app_constants.dart';
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
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: FlutterFlowTheme.of(context).primaryBackground,
          boxShadow: const [
            BoxShadow(
              color: AppConstants.primary,
              blurRadius: 2,
              offset: Offset(0, 2),
            )
          ],
        ),

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                            '${widget.certificate.testResult.subCategory!.name!} -',
                          style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Text(
                            widget.certificate.testResult.level!.name,
                          style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).secondaryText
                          )
                        ),
                      ],
                    ),

                    InkWell(
                      onTap: (){
                        controller.showCertificateDialog(context, widget.certificate);
                      },
                      child: const Icon(
                        FontAwesomeIcons.eye,
                      ),
                    ),
                  ]
                ),
              ),
              const Divider(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Rank - ${widget.certificate.testResult.rank}',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.of(context).secondaryText
                ),
              )
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                'No. of Questions - ${widget.certificate.testResult.noOfQuestions}',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Poppins',
                  color: FlutterFlowTheme.of(context).secondaryText
                )
              )
            )
          ],
        )
        // PieChart(
        //     dataMap: {
        //       'Rank': widget.certificate.testResult.rank!.toDouble(),
        //       'No. of Questions': widget.certificate.testResult.noOfQuestions!.toDouble() - widget.certificate.testResult.rank!.toDouble(),
        //     },
        //     animationDuration: const Duration(milliseconds: 800),
        //     chartLegendSpacing: 32,
        //     chartRadius: MediaQuery.of(context).size.width / 3.2,
        //     colorList: [
        //       FlutterFlowTheme.of(context).primary,
        //       FlutterFlowTheme.of(context).secondary,
        //     ],
        //     initialAngleInDegree: 0,
        //     chartType: ChartType.disc,
        //     ringStrokeWidth: 32,
        //     legendOptions: LegendOptions(
        //       showLegendsInRow: false,
        //       legendPosition: LegendPosition.right,
        //       showLegends: true,
        //       legendShape: BoxShape.circle,
        //       legendTextStyle: FlutterFlowTheme.of(context).bodySmall.override(
        //         fontFamily: 'Poppins',
        //         color: FlutterFlowTheme.of(context).secondaryText,
        //       ),
        //     ),
        //     chartValuesOptions: ChartValuesOptions(
        //   showChartValuesInPercentage: true,
        //   chartValueStyle: FlutterFlowTheme.of(context).bodyMedium.override(
        //     fontFamily: 'Poppins',
        //     color: FlutterFlowTheme.of(context).primaryText
        //   ),
        //   chartValueBackgroundColor: Colors.transparent,
        //   showChartValues: true,
        //   showChartValuesOutside: false,
        //   decimalPlaces: 0,
        // ),
        //       ),
      ),
            ]
          ),
      ),
    );
  }
}
