// lib/services/lesson_service.dart
import 'package:http/http.dart' as http;
import 'package:mss_e_learning/util/lesson_place_holder.dart';
import 'dart:convert';

import '../model/lesson.dart';
import '../model/level.dart';
import '../model/sub_category.dart';

class LessonService {
  final String apiUrl = 'https://learning.cheretanet.com/api';


  Future<Lesson?> fetchLesson(int lessonId) async {
    print('INPUT CHECK: ${lessonId}');
    try {
      final response = await http.get(Uri.parse('$apiUrl/post/$lessonId?populate=true'));
      print(response.body);
      if (response.statusCode == 200) {
        final data = lessonData['data'];
        final subcategory = SubCategory(
          id: data['subcategory']['id'],
          image: data['subcategory']['image'],
          name: data['subcategory']['name'],
        );
        final level = Level(
          id: data['level']['id'],
          name: data['level']['name'],
        );
        final lesson = Lesson(
          id: data['id'],
          image: data['image'],
          title: data['title'],
          description: data['description'],
          subcategory: subcategory,
          level: level,
        );
        return lesson;
      } else {
        print('Error fetching data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
