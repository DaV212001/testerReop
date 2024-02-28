import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/model/answer.dart';
import 'package:mss_e_learning/model/question.dart';
import 'package:mss_e_learning/util/app_routes.dart';
import 'package:mss_e_learning/util/placeHolderData.dart';
import 'package:mss_e_learning/widget/quiz/correct_answer_popup.dart';
import 'package:mss_e_learning/widget/quiz/incorrect_answer_popup.dart';

class QuizController extends GetxController {
  final questions = <Question>[].obs;
  final currentQuestionIndex = 0.obs;
  final progress = 0.obs; //for the progress bar
  final noOfCorrectQuestions = 0.obs; //for the progress bar
  final quizEndRoute = "".obs;
  final practiceMode = false.obs;

  @override
  void onInit() {
    questions.addAll(PlaceHolderData.questions); //TODO USE SERVICE LAYER
    super.onInit();
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

  void nextQuestion() {
    // if the test ends
    if (progress.value == questions.length) {
      SmartDialog.dismiss();
      quizEndRoute.value = AppRoutes.initial; //set route to next section maybe
      Get.toNamed(AppRoutes.quizEnd);
      return;
    }
    currentQuestionIndex.value++;
  }

  /// So in practice mode wrong questions are taken to the back of the queue for
  /// second attempt
  final wrongQuestionsIndex = <int>[].obs;

  void selectAnswerPractice(Answer answer) {
    if (answer.isCorrectAnswer) {
      handleCorrectAnswer();
    } else {
      handleIncorrectAnswer();
    }
  }

  void handleCorrectAnswerPractice() {
    progress.value++;
    if (wrongQuestionsIndex.contains(currentQuestionIndex.value)) {
      wrongQuestionsIndex.remove(currentQuestionIndex.value);
    }
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

  void handleIncorrectAnswerPractice() {
    // move to the back of the queue
    if (wrongQuestionsIndex.contains(currentQuestionIndex.value)) {
      wrongQuestionsIndex.remove(currentQuestionIndex.value);
      wrongQuestionsIndex.add(currentQuestionIndex.value);
    }
    // add to the queue
    if (!wrongQuestionsIndex.contains(currentQuestionIndex.value)) {
      wrongQuestionsIndex.add(currentQuestionIndex.value);
    }
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

  void nextQuestionPractice() {
    // if all questions are answered
    if (progress.value == questions.length) {
      SmartDialog.dismiss();
      quizEndRoute.value = AppRoutes.initial; //set route to next section maybe
      Get.toNamed(AppRoutes.quizEnd);
      return;
    }
    // if the user has attempted all the questions at least once
    // start checking the wrong question list
    if (progress.value + wrongQuestionsIndex.length ==
        questions.length) {
      currentQuestionIndex.value = wrongQuestionsIndex[0];
      return;
    }
    // if this is the users first attempt of a questions
    currentQuestionIndex.value++;
  }
}
