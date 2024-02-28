class Answer {
  int id;
  String answer;
  bool isCorrectAnswer;
  String testQuestionId;

  Answer({
    required this.id,
    required this.answer,
    required this.isCorrectAnswer,
    required this.testQuestionId,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as int,
      answer: json['answer'] as String,
      isCorrectAnswer: json['is_correct_answer'] == "1" ? true : false,
      testQuestionId: json['test_question_id'],
    );
  }
}
