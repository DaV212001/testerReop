import 'package:mss_e_learning/util/app_constants.dart';

import 'lesson.dart';
import 'level.dart';

class SubCategory {
  int? id;
  String? name;
  String? image;
  int? price;
  String? categoryId;
  String? categoryName;
  List<Level>? levels = [];

  SubCategory({
    this.id,
    this.name,
    this.price,
    this.image,
    this.categoryId,
    this.categoryName,
    this.levels
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    print('CHECKING PARESE: ${json['levels']}');
    List<Level>? levels = [];
    if(json.containsKey('levels')){
      print('LEVEL  CONTAINED');
      List<dynamic> levellist = json['levels'];
      print('CHECKING SIZE: ${levellist.length}');
      levels = levellist.map((element) => Level.fromJson(element)).toList();
    }
    print('CHECKING LEVELS: $levels');
    return SubCategory(
        id: json['id'],
        name: json['name'],
        price: json.containsKey('price')?json['price'] is int ? json['price'] : int.parse(json['price']):0,
        image: AppConstants.imagebaseurl+json['image'],
        categoryId: json['category_id'],
        categoryName: json.containsKey('category')?json['category']['name']:'',
        levels: levels
    );
  }
}

