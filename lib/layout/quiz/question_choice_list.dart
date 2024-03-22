import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/quiz_controller.dart';

class QuestionChoiceList extends StatefulWidget {
  const QuestionChoiceList({super.key});

  @override
  State<QuestionChoiceList> createState() => _QuestionChoiceListState();
}

class _QuestionChoiceListState extends State<QuestionChoiceList> {
  int selectedAnswerId = -1;

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    final controller = Get.find<QuizController>();
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: controller.questions[controller.currentQuestionIndex.value].answers.length,
          itemBuilder: (context, index) {
            final answer = controller.questions[controller.currentQuestionIndex.value].answers[index];
            final isSelected = selectedAnswerId == answer.id;
            return GestureDetector(
              onTap: () => {
                setState(() {
                  selectedAnswerId = answer.id;
                }),
                controller.selectAnswer(answer)
              },
              // temp solution refreshing the widget
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? Color(0xFFFF2C20).withOpacity(0.9)
                        : theme.primaryText.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected
                      ? Color(0xFFFF2C20).withOpacity(0.9)
                      : Colors.transparent,
                ),
                child: ListTile(
                  title: Text(
                    answer.answer,
                    style: theme.bodyMedium.copyWith(
                      color: isSelected ? theme.primaryBtnText : null,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
