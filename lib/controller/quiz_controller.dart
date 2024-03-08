import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/model/answer.dart';
import 'package:mss_e_learning/model/error_data.dart';
import 'package:mss_e_learning/model/question.dart';
import 'package:mss_e_learning/service/certificate_service.dart';
import 'package:mss_e_learning/service/quiz_service.dart';
import 'package:mss_e_learning/util/api_call_status.dart';
import 'package:mss_e_learning/util/app_routes.dart';
import 'package:mss_e_learning/util/error_util.dart';
import 'package:mss_e_learning/widget/quiz/correct_answer_popup.dart';
import 'package:mss_e_learning/widget/quiz/incorrect_answer_popup.dart';

class QuizController extends GetxController {
  final String levelid;
  final String subCatId;
  QuizController( {required this.subCatId,required this.levelid});

  final questions = <Question>[].obs;
  final currentQuestionIndex = 0.obs;
  final progress = 0.obs; //for the progress bar
  final noOfCorrectQuestions = 0.obs; //for the progress bar
  final quizEndRoute = "".obs;
  final practiceMode = false.obs;

  @override
  void onInit() {
    getQuestions(subCatId, levelid);//TODO REPLACE STATIC DATA
    super.onInit();
  }

  final errorData = ErrorData(title: "", body: "", image: "").obs;
  final status = ApiCallStatus.holding.obs;


  getQuestions(String subID, String levelID) async {
    try {
      questions.clear();
      status.value = ApiCallStatus.loading;

      final response = await QuizService.fetchQuestionsByLevelId(subID, levelID);
      questions.addAll(response);

      status.value = ApiCallStatus.success;
    } on Exception catch (fetchError) {
      status.value = ApiCallStatus.error;
      errorData.value = ErrorUtil.getErrorData(fetchError.toString());
    }
  }

  void selectAnswer(Answer answer) {
    progress.value++;
    if (answer.isCorrectAnswer) {
      handleCorrectAnswer();
    } else {
      handleIncorrectAnswer();
    }
  }



  void handleCorrectAnswer() {
    noOfCorrectQuestions.value++;
    SmartDialog.show(
        maskColor: Get.theme.colorScheme.onBackground.withOpacity(0.4),
        alignment: Alignment.bottomCenter,
        backDismiss: false,
        clickMaskDismiss: false,
        builder: (_) {
          return CorrectAnswerPopup(
            next: () {
              nextQuestion();
            },
          );
        });
  }

  void handleIncorrectAnswer() {
    Answer? correctAnswer = questions[currentQuestionIndex.value]
        .answers
        .firstWhere((answer) => answer.isCorrectAnswer == true,
            orElse: () => Answer(
                id: -1,
                answer: "",
                isCorrectAnswer: true,
                testQuestionId: "1"));

    SmartDialog.show(
        maskColor: Get.theme.colorScheme.onBackground.withOpacity(0.4),
        alignment: Alignment.bottomCenter,
        backDismiss: false,
        clickMaskDismiss: false,
        builder: (_) {
          return IncorrectAnswerPopup(
            answer: correctAnswer.answer,
            next: () {
              nextQuestion();
            },
          );
        });
  }

  void nextQuestion() async {
    // if the test ends
    if (progress.value == questions.length) {
      SmartDialog.dismiss();
      String certificateGeneration = '';
      try {
        status.value = ApiCallStatus.loading;

        await QuizService().sendTestResult(
            int.parse(levelid),
            int.parse(subCatId),
            noOfCorrectQuestions.value,
            questions.length
        );

        certificateGeneration = await CertificateServices().generateCertificate();
        quizEndRoute.value = certificateGeneration == 'success' ?
        AppRoutes.certificate
            :
        AppRoutes.initial;

        status.value = ApiCallStatus.success;

      } on Exception catch (fetchError) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(fetchError.toString()),
          )
        );
      }
      Get.toNamed(AppRoutes.quizEnd);
      return;
    }
    currentQuestionIndex.value++;
  }


}
