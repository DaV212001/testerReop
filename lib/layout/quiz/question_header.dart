import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mss_e_learning/controller/quiz_controller.dart';

class QuestionHeader extends GetView<QuizController> {
  const QuestionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Obx(() => Text(
              controller
                  .questions[controller.currentQuestionIndex.value].question,
              style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.8)),
            )),
        const SizedBox(height: 10),
        Text(
          "Select the correct answer",
          style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.8)),
        ),
      ],
    );
  }
}
