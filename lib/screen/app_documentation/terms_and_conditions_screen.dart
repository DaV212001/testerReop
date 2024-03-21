import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/terms_and_conditions_controller.dart';

class TermAndConditionScreen extends StatelessWidget {
  final TermAndConditionController controller = Get.put(TermAndConditionController());

  TermAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Obx(
            () {
          if (controller.isLoading.isTrue) {
            return Center(child: CircularProgressIndicator());
          } else {
            final termAndCondition = controller.termAndCondition.value;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    termAndCondition.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(termAndCondition.description),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
