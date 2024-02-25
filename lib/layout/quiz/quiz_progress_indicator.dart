import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/quiz_controller.dart';

class QuizProgressIndicator extends GetView<QuizController> {
  const QuizProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Obx(
      () => Row(
        children: controller.questions.asMap().entries.map((entry) {
          final index = entry.key;
          return Expanded(
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: controller.noOfCorrectQuestions > index
                    ? theme.colorScheme.primary
                    : theme.unselectedWidgetColor.withOpacity(0.2),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 4),
            ),
          );
        }).toList(),
      ),
    );
  }
}
