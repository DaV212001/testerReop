// lib/models/lesson_model.dart

import 'package:mss_e_learning/model/sub_category.dart';

import 'level.dart';

class Lesson {
  final int id;
  final String image;
  final String title;
  final String description;
  final SubCategory subcategory;
  final Level level;

  Lesson({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.subcategory,
    required this.level,
  });
}





