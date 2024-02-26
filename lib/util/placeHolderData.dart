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
  static List<Answer> answers3 = [
    Answer(
      id: 7,
      answer:
          "Python is an interpreted, high-level, general-purpose programming language.",
      isCorrectAnswer: true,
      testQuestionId: "3",
    ),
    Answer(
      id: 8,
      answer: "Python is a markup language used for creating web pages.",
      isCorrectAnswer: false,
      testQuestionId: "3",
    ),
    Answer(
      id: 9,
      answer: "Python is a type of snake found in Asia.",
      isCorrectAnswer: false,
      testQuestionId: "3",
    ),
  ];

  static List<Answer> answers4 = [
    Answer(
      id: 10,
      answer: "HTML stands for Hyper Text Markup Language.",
      isCorrectAnswer: true,
      testQuestionId: "4",
    ),
    Answer(
      id: 11,
      answer: "HTML is a programming language used for building mobile apps.",
      isCorrectAnswer: false,
      testQuestionId: "4",
    ),
    Answer(
      id: 12,
      answer: "HTML is a database management system.",
      isCorrectAnswer: false,
      testQuestionId: "4",
    ),
  ];

  static List<Answer> answers5 = [
    Answer(
      id: 13,
      answer:
          "Git is a version control system used for tracking changes in source code during software development.",
      isCorrectAnswer: true,
      testQuestionId: "5",
    ),
    Answer(
      id: 14,
      answer: "Git is a programming language.",
      isCorrectAnswer: false,
      testQuestionId: "5",
    ),
    Answer(
      id: 15,
      answer: "Git is a database management system.",
      isCorrectAnswer: false,
      testQuestionId: "5",
    ),
  ];

  static Question question3 = Question(
    id: 3,
    question: "What is Python?",
    subcategoryId: 2,
    levelId: 1,
    answers: answers3,
  );

  static Question question4 = Question(
    id: 4,
    question: "What is HTML?",
    subcategoryId: 2,
    levelId: 1,
    answers: answers4,
  );

  static Question question5 = Question(
    id: 5,
    question: "What is Git?",
    subcategoryId: 2,
    levelId: 1,
    answers: answers5,
  );

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
    question3,
    question4,
    question5,
  ];
}
