import 'package:mss_e_learning/model/answer.dart';
import 'package:mss_e_learning/model/question.dart';

class PlaceHolderData {
  static List<Answer> answers1 = [
    Answer(
        id: 1,
        answer: "Answer one",
        isCorrectAnswer: false,
        testQuestionId: "1"),
    Answer(
        id: 2,
        answer:
        "Answer Two Answer Two Answer Two Answer Two Answer Two Answer Two",
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

  static List<Answer> answers2 = [
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

  static Question question1 = Question(
    id: 1,
    question: "What is Programming?",
    subcategoryId: 1,
    levelId: 1,
    answers: answers1,
  );

  static Question question2 = Question(
    id: 2,
    question: "What is kotlin",
    subcategoryId: 1,
    levelId: 1,
    answers: answers2,
  );
  static List<Question> questions = [question1, question2, question2, question2];

}