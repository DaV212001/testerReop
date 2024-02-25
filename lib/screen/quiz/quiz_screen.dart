import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/layout/quiz/quiz_progress_indicator.dart';
import 'package:mss_e_learning/model/answer.dart';
import 'package:mss_e_learning/model/question.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Answer> answers1 = [
      Answer(
          id: 1,
          answer: "Answer one",
          isCorrectAnswer: false,
          testQuestionId: "1"),
      Answer(
          id: 2,
          answer: "Answer Two",
          isCorrectAnswer: false,
          testQuestionId: "1"),
      Answer(
          id: 3,
          answer: "Answer three",
          isCorrectAnswer: true,
          testQuestionId: "1"),
      Answer(
          id: 4,
          answer: "Answer Four",
          isCorrectAnswer: false,
          testQuestionId: "1"),
    ];

    List<Answer> answers2 = [
      Answer(
          id: 5,
          answer: "Answer 5",
          isCorrectAnswer: false,
          testQuestionId: "2"),
      Answer(
          id: 6,
          answer: "Answer 6",
          isCorrectAnswer: true,
          testQuestionId: "2"),
    ];

    Question question1 = Question(
      id: 1,
      question: "What is Programming?",
      subcategoryId: 1,
      levelId: 1,
      answers: answers1,
    );

    Question question2 = Question(
      id: 2,
      question: "What is kotlin",
      subcategoryId: 1,
      levelId: 1,
      answers: answers2,
    );
    List<Question> questions = [question1, question2, question2, question2];
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            QuizProgressIndicator(items: questions, progress: 1),
            Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close,
                      size: 35,
                      color: theme.colorScheme.onBackground.withOpacity(0.5)),
                ))
          ],
        ),
      )),
    );
  }
}
