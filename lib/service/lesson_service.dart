import 'package:http/http.dart' as http;
import 'package:mss_e_learning/util/app_constants.dart';
import 'package:mss_e_learning/util/lesson_place_holder.dart';
import 'dart:convert';

import '../model/lesson.dart';
import '../model/lesson_description.dart';
import '../model/level.dart';
import '../model/sub_category.dart';

class LessonService {

  static Future<List<Level>> fetchLevelsById(String subCategoryId) async {
    final response = await http.get(
        Uri.parse('${AppConstants.exampleAPI}/sub_category/$subCategoryId?populate=true'));
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
        Uri.parse('${AppConstants.exampleAPI}/post/$levelId?populate=true'));
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
}