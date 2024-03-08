import 'package:mss_e_learning/util/app_constants.dart';

class SubCategory {
  int? id;
  String? name;
  String? image;
  String? categoryId;
  String? categoryName;

  SubCategory({
    this.id,
    this.name,
    this.image,
    this.categoryId,
    this.categoryName
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
        id: json['id'],
        name: json['name'],
        image: AppConstants.imagebaseurl+json['image'],
        categoryId: json['category_id'],
        categoryName: json.containsKey('category')?json['category']['name']:''
    );
  }
}

