import 'package:mss_e_learning/model/answer.dart';

class Question {
  int id;
  String question;
  int subcategoryId;
  int levelId;
  List<Answer> answers;

  Question({
    required this.id,
    required this.question,
    required this.subcategoryId,
    required this.levelId,
    required this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<Answer> answersList = [];
    if (json['answers'] != null) {
      json['answers'].forEach((answerJson) {
        answersList.add(Answer.fromJson(answerJson));
      });
    }

    return Question(
      id: json['id'] as int,
      question: json['question'] as String,
      subcategoryId: json['subcategory_id'] as int,
      levelId: json['level_id'] as int,
      answers: answersList,
    );
  }
}
