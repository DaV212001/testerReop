import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mss_e_learning/model/question.dart';
import 'package:mss_e_learning/service/authorization_service.dart';
import 'package:mss_e_learning/util/app_constants.dart';

import '../model/test_result.dart';

class QuizService {
  static Future<List<Question>> fetchQuestionsByLevelId(String subCatID, String levelId) async {
    final response = await http.get(Uri.parse(
        '${AppConstants.api}/test_question_sub_category_level/$subCatID/$levelId?populate=true'));

    print('QUIZZZZZZZZZZZZZZZZZZZZZZZZZZZZ SUB:$subCatID ANDDD LEV: $levelId AND RESPONSE: ${response.body}');
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


  Future<TestResult> sendTestResult(int levelID, int subcatID, int rank, int numberOfQuestions) async {
    const String apiUrl = '${AppConstants.api}/test_result';
    String? token = await AuthService.getAuthorizationToken();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'level_id': levelID,
          'subcategory_id': subcatID,
          'rank': rank,
          'number_of_questions': numberOfQuestions,
        }),
      );

      final responseData = jsonDecode(response.body);
      final bool success = responseData['success'];
      final dynamic message = responseData['message'];

      if (success) {
        return TestResult.fromJson(message);
      } else {
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Error sending test result: $e');
    }
  }



}
