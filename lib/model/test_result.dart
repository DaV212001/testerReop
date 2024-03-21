import 'package:mss_e_learning/model/sub_category.dart';

import 'level.dart';

class TestResult{
  int? id;
  int? userid;
  int? rank;
  int? noOfQuestions;
  Level? level;
  SubCategory? subCategory;

  TestResult({
    this.id,
    this.userid,
    this.rank,
    this.noOfQuestions,
    this.level,
    this.subCategory
  });

  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      id: json['id'] is String? int.parse(json['id']):json['id'],
      userid: json['user_id'] is String? int.parse(json['user_id']):json['user_id'],
      rank: json['rank'] is String? int.parse(json['rank']):json['rank'],
      noOfQuestions: json['number_of_questions'] is String? int.parse(json['number_of_questions']):json['number_of_questions'],
      level: json.containsKey('level')?Level.fromJson(json['level']):null,
      subCategory: json.containsKey('subcategory')?SubCategory.fromJson(json['subcategory']):null,
    );
  }
}