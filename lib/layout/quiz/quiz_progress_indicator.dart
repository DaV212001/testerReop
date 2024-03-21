import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/quiz_controller.dart';

class QuizProgressIndicator extends GetView<QuizController> {
  const QuizProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Obx(
      () => Row(
        children: controller.questions.asMap().entries.map((entry) {
          final index = entry.key;
          return Expanded(
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: controller.progress.value == index
                    ? theme.primary
                    : theme.primaryText.withOpacity(0.25),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 4),
            ),
          );
        }).toList(),
      ),
    );
  }
}
