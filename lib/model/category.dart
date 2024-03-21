import 'package:mss_e_learning/model/sub_category.dart';
import 'package:mss_e_learning/util/app_constants.dart';

class Category {
  int id;
  String name;
  String image;
  List<SubCategory> subcategories;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.subcategories
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    List<SubCategory> subcategories = [];
    if (json['subcategory'] != null) {
      json['subcategory'].forEach((subcategoryJson) {
        subcategories.add(SubCategory.fromJson(subcategoryJson));
      });
    }
    return Category(
      id: json.containsKey('id')?json['id']:-1,
      name: json.containsKey('name') ?json['name']:'',
      image: json.containsKey('image')?AppConstants.imagebaseurl + json['image']:'',
      subcategories: subcategories,
    );
  }
}