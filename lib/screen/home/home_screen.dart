import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/category_controller.dart';
import 'package:mss_e_learning/util/api_call_status.dart';
import 'package:mss_e_learning/widget/error_card.dart';

import '../../layout/home/category_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
          child: Center(
        child: Obx(
          () => controller.status.value == ApiCallStatus.loading
              ? const Padding(
                padding: EdgeInsets.all(50.0),
                child: Center(child: CircularProgressIndicator()),
              )
              : controller.status.value == ApiCallStatus.error
                  ? ErrorCard(
                      errorData: controller.errorData.value,
                      refresh: () => controller.getCategories(),
                    )
                  : ListView(children: const [CategorySection()]),
        ),
      )),
    );
  }
}
