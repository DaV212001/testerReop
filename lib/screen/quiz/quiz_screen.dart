import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/quiz_controller.dart';
import 'package:mss_e_learning/layout/quiz/question_choice_list.dart';
import 'package:mss_e_learning/layout/quiz/question_header.dart';
import 'package:mss_e_learning/layout/quiz/quiz_progress_indicator.dart';
import 'package:mss_e_learning/util/api_call_status.dart';
import 'package:mss_e_learning/widget/error_card.dart';

import '../../layout/password/header_image_and_text.dart';

class QuizScreen extends StatefulWidget {
  final String? subcatID;
  final String? levelId;
  const QuizScreen({super.key, this.subcatID, this.levelId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late QuizController controller;
  @override
  void initState() {
    controller = Get.put(
        QuizController(subCatId: widget.subcatID!, levelid: widget.levelId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    return Scaffold(
        backgroundColor: theme.primaryBackground,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close,
                  size: 35, color: theme.primaryText.withOpacity(0.5)),
            ),
          ],
        ),
        body: Center(
          child: Obx(
            () => controller.status.value == ApiCallStatus.loading
                ? const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : controller.status.value == ApiCallStatus.error
                    ? ErrorCard(
                        errorData: controller.errorData.value,
                        refresh: () => controller.getQuestions(
                            widget.subcatID!, widget.levelId!),
                      )
                    : controller.questions.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Column(children: [
                              QuizProgressIndicator(),
                              SizedBox(height: 30),
                              QuestionHeader(),
                              SizedBox(height: 10),
                              QuestionChoiceList(),
                              SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FFButtonWidget(
                                        text: 'Previous',
                                        onPressed: () {
                                          controller.previous();
                                        },
                                        options: FFButtonOptions(
                                          width: 150,
                                          height: 50,
                                          color: theme.primary,
                                          textStyle: theme.titleSmall,
                                          elevation: 0,
                                          borderSide: BorderSide(
                                            color: theme.primary,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        )),
                                    FFButtonWidget(
                                        text: controller.currentQuestionIndex.value ==
                                                controller.questions.length - 1
                                            ? 'Submit'
                                            : 'Next',
                                        onPressed: () {
                                          if (controller.currentQuestionIndex.value ==
                                              controller.questions.length - 1) {
                                            controller.submitAnswers();
                                          } else {
                                            controller.next();
                                          }
                                        },
                                        options: FFButtonOptions(
                                          width: 150,
                                          height: 50,
                                          color: controller.isAnswered(
                                              controller
                                                  .questions[controller
                                                  .currentQuestionIndex
                                                  .value]
                                                  .id)
                                              ? theme.primary
                                              : Colors.grey,
                                          textStyle: theme.titleSmall,
                                          elevation: 0,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ))
                                  ])
                            ]))
                        : Center(
                            child: HeaderImageAndText(
                              showbackButton: false,
                              imagePath:
                                  'assets/images/illustrations/no_certificates.svg',
                              headerText: 'No questions for this lesson',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
          ),
        ));
  }
}
