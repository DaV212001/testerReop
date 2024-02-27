import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/quiz_controller.dart';
import 'package:mss_e_learning/layout/quiz/question_choice_list.dart';
import 'package:mss_e_learning/layout/quiz/question_header.dart';
import 'package:mss_e_learning/layout/quiz/quiz_progress_indicator.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(QuizController());
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Scaffold(
        backgroundColor: theme.primaryBackground,
        appBar: AppBar(
          backgroundColor: theme.primaryBackground,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close,
                  size: 35,
                  color: theme.primaryText.withOpacity(0.5)),
            ),
          ],
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: const Column(children: [
              QuizProgressIndicator(),
              SizedBox(height: 30),
              QuestionHeader(),
              SizedBox(height: 10),
              QuestionChoiceList(),
              SizedBox(height: 20)
            ])));
  }
}
