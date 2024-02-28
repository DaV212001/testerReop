import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mss_e_learning/model/question.dart';
import 'package:mss_e_learning/util/app_constants.dart';

class QuizService {
  static Future<List<Question>> fetchQuestionsByLevelId(String levelId) async {
    final response = await http.get(Uri.parse(
        '${AppConstants.api}/test_question_by_level/$levelId?populate=true'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> questionJson = jsonData["data"]["data"];
      return questionJson.map((item) {
        return Question.fromJson(item);
      }).toList();
    } else {
      throw Exception(response.statusCode);
    }
  }
}
