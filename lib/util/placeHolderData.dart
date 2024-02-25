import 'package:mss_e_learning/model/answer.dart';
import 'package:mss_e_learning/model/question.dart';

class PlaceHolderData {
  static List<Answer> answers1 = [
    Answer(
      id: 1,
      answer:
          "Programming is the process of creating instructions that tell a computer what to do.",
      isCorrectAnswer: true,
      testQuestionId: "1",
    ),
    Answer(
      id: 2,
      answer:
          "Programming involves writing code to develop software applications.",
      isCorrectAnswer: false,
      testQuestionId: "1",
    ),
    Answer(
      id: 3,
      answer: "Programming is a method of communication with computers.",
      isCorrectAnswer: false,
      testQuestionId: "1",
    ),
  ];

  static List<Answer> answers2 = [
    Answer(
      id: 4,
      answer:
          "Kotlin is a modern programming language used for Android app development.",
      isCorrectAnswer: true,
      testQuestionId: "2",
    ),
    Answer(
      id: 5,
      answer: "Kotlin is a scripting language used for web development.",
      isCorrectAnswer: false,
      testQuestionId: "2",
    ),
    Answer(
      id: 6,
      answer: "Kotlin is a database management system.",
      isCorrectAnswer: false,
      testQuestionId: "2",
    ),
  ];

  static Question question1 = Question(
    id: 1,
    question: "What is Programming?",
    subcategoryId: 1,
    levelId: 1,
    answers: answers1,
  );

  static Question question2 = Question(
    id: 2,
    question: "What is Kotlin?",
    subcategoryId: 1,
    levelId: 1,
    answers: answers2,
  );

  static List<Question> questions = [
    question1,
    question2,
    question1,
    question2
  ];
}
