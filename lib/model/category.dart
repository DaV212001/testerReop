import 'package:mss_e_learning/model/sub_category.dart';

class Category {
  int id;
  String name;
  String image;
  List<SubCategory> subcategory;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.subcategory
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    List<SubCategory> subcategories = [];
    if (json['subcategory'] != null) {
      json['subcategory'].forEach((subcategoryJson) {
        subcategories.add(SubCategory.fromJson(subcategoryJson));
      });
    }
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      subcategory: subcategories,
    );
  }
}