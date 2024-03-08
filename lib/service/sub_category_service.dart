import 'dart:convert';
import 'package:http/http.dart';
import '../model/sub_category.dart';
import '../util/app_constants.dart';

class SubCategoryService{

  Future<SubCategory> getSubCatById(int subCategoryId) async {
    final response = await get(
        Uri.parse('${AppConstants.api}/sub_category/$subCategoryId?populate=true'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      Map<String, dynamic> levelsJson = jsonData["data"];
      return SubCategory.fromJson(levelsJson);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<SubCategory>> getSubCategories() async {
    final response = await get(
        Uri.parse('${AppConstants.api}/sub_category?populate=true'));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> levelsJson = jsonData["data"]['data'];
      return levelsJson.map((levelJson) => SubCategory.fromJson(levelJson)).toList();
    } else {
      throw Exception(response.statusCode);
    }
  }

}
