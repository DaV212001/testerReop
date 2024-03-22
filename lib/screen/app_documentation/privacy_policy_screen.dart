import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mss_e_learning/controller/privacy_policy_controller.dart';

import '../../util/api_call_status.dart';
import '../../widget/error_card.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {



  @override
  Widget build(BuildContext context) {

    PrivacyPolicyControl controller = Get.put(PrivacyPolicyControl());


      FlutterFlowTheme theme = FlutterFlowTheme.of(context);
      return Scaffold(
        backgroundColor: theme.primaryBackground,
          appBar: AppBar(
            title: Text('Privacy Policy'),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                  Icons.arrow_back_ios_rounded
              ),
            ),
          ),
          body: Obx(() => controller.status.value == ApiCallStatus.loading
              ? const Padding(
            padding: EdgeInsets.all(40.0),
            child: Center(child: CircularProgressIndicator()),
          )
              : controller.status.value == ApiCallStatus.error
              ? ErrorCard(
            errorData: controller.errorData.value,
            refresh: () => controller.fetchPrivacyPolicy(),
          )
              : RefreshIndicator(
              color: Color(0xFFFF2C20),
              displacement: 100,
              onRefresh: () => controller.fetchPrivacyPolicy(),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                          controller.privacyPolicy.value.title!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Text(controller.privacyPolicy.value.description!),
                  ],
                ),
              )))
      );
    }
}
