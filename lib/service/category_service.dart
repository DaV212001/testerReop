import 'dart:convert';

import 'package:mss_e_learning/util/app_constants.dart';

import '../model/category.dart';
import 'package:http/http.dart' as http;
class CategoryService{
  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(
        Uri.parse('${AppConstants.api}/category?populate=true'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> categoriesJson = jsonData["data"]["data"];
      return categoriesJson.map((item) {
        return Category.fromJson(item);
      }).toList();
    } else {
      throw Exception(response.statusCode.toString());
    }
  }
}