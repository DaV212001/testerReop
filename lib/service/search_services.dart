import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mss_e_learning/model/sub_category.dart';
import 'package:mss_e_learning/model/category.dart';
import 'package:mss_e_learning/model/lesson.dart';
import 'package:mss_e_learning/util/app_constants.dart';
class SearchService {
  Future<List> getSearchData(String searchName) async {
    const url = '${AppConstants.api}/search';
    final body = jsonEncode({'name': searchName});

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse categories
        List<Category> categories = [];
        if (data['data'][0] != null && data['data'][0]['category'] != null) {
          data['data'][0]['category'].forEach((categoryJson) {
            categories.add(Category.fromJson(categoryJson));
          });
        }

        // Parse subcategories
        List<SubCategory> subcategories = [];
        if (data['data'][1] != null && data['data'][1]['subcategory'] != null) {
          data['data'][1]['subcategory'].forEach((subcategoryJson) {
            subcategories.add(SubCategory.fromJson(subcategoryJson));
          });
        }

        // Parse lessons (posts)
        List<Lesson> lessons = [];
        if (data['data'][2] != null && data['data'][2]['post'] != null) {
          data['data'][2]['post'].forEach((lessonJson) {
            lessons.add(Lesson.fromJson(lessonJson));
          });
        }
        print('CATEGORY: ${categories.length}');
        print('SUBCATEGORY: ${subcategories.length}');
        print('LESSON: ${lessons.length}');
        return [categories, subcategories, lessons];
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching data');
    }
  }
}
