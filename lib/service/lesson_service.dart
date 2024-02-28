import 'package:http/http.dart' as http;
import 'package:mss_e_learning/util/app_constants.dart';
import 'package:mss_e_learning/util/lesson_place_holder.dart';
import 'dart:convert';

import '../model/lesson.dart';
import '../model/lesson_description.dart';
import '../model/level.dart';
import '../model/sub_category.dart';
import 'authorization_service.dart';

class LessonService {

  static Future<List<Level>> fetchLevelsById(String subCategoryId) async {
    final response = await http.get(
        Uri.parse('${AppConstants.api}/sub_category/$subCategoryId?populate=true'));
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> levelsJson = jsonData["data"]["levels"];
      return levelsJson.map((item) {
        return Level.fromJson(item);
      }).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  Future<LessonDescription> fetchLessonById(String levelId) async {
    final response = await http.get(
        Uri.parse('${AppConstants.api}/post/$levelId?populate=true'));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      Map<String, dynamic> levelsJson = jsonData["data"];
      return LessonDescription.fromJson(levelsJson);
    } else {
      throw Exception('Failed to fetch categories');
    }
  }
  static Future<http.Response> addBookmarkLesson(int lessonId) async{
    print(jsonEncode({
      "post_id": lessonId
    }));
    String? token = await AuthService.getAuthorizationToken();
    print(token);
    final response = await http.post(
        Uri.parse('${AppConstants.api}/book_mark'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 5|wrjSTopObsSpWq8oDUyYBoHaL31716yezsuTwowE804015a2'
        },
        body: jsonEncode({
          "post_id": lessonId
        })
    );
    print(response.body);
    print(response.statusCode);
    return response;
  }
  static Future<http.Response> deleteBookmarkLesson(int lessonId) async{
    print(jsonEncode({
      "post_id": lessonId
    }));
    String? token = await AuthService.getAuthorizationToken();
    print(token);
    final response = await http.delete(
        Uri.parse('${AppConstants.api}/book_mark'),
        headers: {
          'Content-type': 'application/json',
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "post_id": lessonId
        })
    );
    return response;
  }
}