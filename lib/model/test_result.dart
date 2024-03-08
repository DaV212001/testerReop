import 'package:mss_e_learning/model/sub_category.dart';

import 'level.dart';

class TestResult{
  int? id;
  String? userid;
  String? rank;
  String? noOfQuestions;
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
      id: json['id'],
      userid: json['user_id'],
      rank: json['rank'],
      noOfQuestions: json['number_of_questions'],
      level: Level.fromJson(json['level']),
      subCategory: SubCategory.fromJson(json['subcategory']),
    );
  }
}