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
  QuizController({required this.subCatId, required this.levelid});

  final questions = <Question>[].obs;
  final currentQuestionIndex = 0.obs;
  final progress = 0.obs; //for the progress bar
  final noOfCorrectQuestions = 0.obs; //for the progress bar
  final quizEndRoute = "".obs;
  final practiceMode = false.obs;

  @override
  void onInit() {
    getQuestions(subCatId, levelid);
    super.onInit();
  }

  final errorData = ErrorData(title: "", body: "", image: "").obs;
  final status = ApiCallStatus.holding.obs;



  getQuestions(String subID, String levelID) async {
    try {
      questions.clear();
      status.value = ApiCallStatus.loading;

      final response =
          await QuizService.fetchQuestionsByLevelId(subID, levelID);
      questions.addAll(response);

      status.value = ApiCallStatus.success;
    } on Exception catch (fetchError) {
      status.value = ApiCallStatus.error;
      errorData.value = ErrorUtil.getErrorData(fetchError.toString());
    }
  }
  List<Answer> correctAnswers = <Answer>[].obs;
  List<Answer> incorrectAnswers = <Answer>[].obs;
  void selectAnswer(Answer answer) {
    if (answer.isCorrectAnswer) {
      handleCorrectAnswer(answer);
    } else {
      handleIncorrectAnswer(answer);
    }
  }

  void handleCorrectAnswer(Answer answer) {
    // noOfCorrectQuestions.value++;
    if(correctAnswers.length > currentQuestionIndex.value){
      correctAnswers.removeWhere((element) => element.testQuestionId == answer.testQuestionId);
      incorrectAnswers.removeWhere((element) => element.testQuestionId == answer.testQuestionId);
      correctAnswers.add(answer);
      print('(length based) correct answers: ${correctAnswers.length}');
      noOfCorrectQuestions.value++;
    } else{
      if(isAnswered(questions[currentQuestionIndex.value].id)){
        correctAnswers.removeWhere((element) => element.testQuestionId == answer.testQuestionId);
        incorrectAnswers.removeWhere((element) => element.testQuestionId == answer.testQuestionId);
        correctAnswers.add(answer);
        print('(already been answered) correct answers: ${correctAnswers.length}');
        noOfCorrectQuestions.value++;
      }else {
        correctAnswers.add(answer);
        print('(has never been answered) correct answers: ${correctAnswers.length}');
        noOfCorrectQuestions.value++;
      }
    }

    // SmartDialog.show(
    //     maskColor: Get.theme.colorScheme.onBackground.withOpacity(0.4),
    //     alignment: Alignment.bottomCenter,
    //     backDismiss: false,
    //     clickMaskDismiss: false,
    //     builder: (_) {
    //       return CorrectAnswerPopup(
    //         next: () {
    //           nextQuestion();
    //         },
    //       );
    //     });
  }

  void handleIncorrectAnswer(Answer answer) {
    print('INCORRECT');
    if(incorrectAnswers.length > currentQuestionIndex.value){

      correctAnswers.removeWhere((element) => element.testQuestionId == answer.testQuestionId);
      incorrectAnswers.removeWhere((element) => element.testQuestionId == answer.testQuestionId);

      incorrectAnswers.add(answer);

      print('(length based)incorrect answers: ${incorrectAnswers.length}');
      noOfCorrectQuestions.value--;
    } else{
      if(isAnswered(questions[currentQuestionIndex.value].id)){

        print('(already been answered) correct answers list before answer removal: ${correctAnswers.length}');
        correctAnswers.removeWhere((element) => element.testQuestionId == answer.testQuestionId);
        print('(already been answered) correct answers list after answer removal: ${correctAnswers.length}\n\n');

        print('(already been answered) incorrect answers list before answer removal: ${incorrectAnswers.length}');
        incorrectAnswers.removeWhere((element) => element.testQuestionId == answer.testQuestionId);
        print('(already been answered) incorrect answers list after answer removal: ${incorrectAnswers.length}\n\n');

        incorrectAnswers.add(answer);
        print('(already answered) incorrect answers: ${incorrectAnswers.length}');
        noOfCorrectQuestions.value--;
      } else {
        incorrectAnswers.add(answer);
        print('(has never been answered) incorrect answers: ${incorrectAnswers
            .length}');
        noOfCorrectQuestions.value--;
      }
    }

    // Answer? correctAnswer = questions[currentQuestionIndex.value].answers.firstWhere((answer) => answer.isCorrectAnswer == true,
    //         orElse: () => Answer(
    //             id: -1,
    //             answer: "",
    //             isCorrectAnswer: true,
    //             testQuestionId: "1"));
    //
    // SmartDialog.show(
    //     maskColor: Get.theme.colorScheme.onBackground.withOpacity(0.4),
    //     alignment: Alignment.bottomCenter,
    //     backDismiss: false,
    //     clickMaskDismiss: false,
    //     builder: (_) {
    //       return IncorrectAnswerPopup(
    //         answer: correctAnswer.answer,
    //         next: () {
    //           nextQuestion();
    //         },
    //       );
    //     });
  }
  void previous() {
    if (currentQuestionIndex.value > 0) {
      progress.value--;
      currentQuestionIndex.value--;
    }
  }
  bool isAnswered(int questionId) {
    print(questionId);

    print(correctAnswers.any((answer) => int.parse(answer.testQuestionId) == questionId));

    //////////
    print('CORRECT');
    correctAnswers.forEach((element) {print(element.testQuestionId);});
    //////////

    print(incorrectAnswers.any((answer) => int.parse(answer.testQuestionId) == questionId));

    /////////
    print('INCORRECT');
    incorrectAnswers.forEach((element) {print(element.testQuestionId);});
    /////////

    return correctAnswers.any((answer) => int.parse(answer.testQuestionId ) == questionId) ||
        incorrectAnswers.any((answer) => int.parse(answer.testQuestionId) == questionId);
  }
  void next() {
    if(isAnswered(questions[currentQuestionIndex.value].id)){
      print('ANSWERED');
      progress.value++;
      print('Incorrect answer length: ${incorrectAnswers.length}');
      print('Correct answer length: ${correctAnswers.length}');
      currentQuestionIndex.value++;
    } else{
      print('Incorrect answer length: ${incorrectAnswers.length}');
      print('Correct answer length: ${correctAnswers.length}');
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text("Please select an answer"),
        )
      );
    }
  }

  void submitAnswers() async {
    // if the test ends
      String certificateGeneration = '';
      try {
        status.value = ApiCallStatus.loading;

        await QuizService().sendTestResult(int.parse(levelid),
            int.parse(subCatId), correctAnswers.length, questions.length);

        certificateGeneration =
            await CertificateServices().generateCertificate();
        quizEndRoute.value = certificateGeneration == 'success'
            ? AppRoutes.certificate
            : AppRoutes.initial;

        status.value = ApiCallStatus.success;
        Get.toNamed(AppRoutes.quizEnd);
      } on Exception catch (fetchError) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(fetchError.toString()),
        ));
      }

      return;
  }
}
