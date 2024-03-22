import 'dart:convert';
import 'package:http/http.dart';
import '../model/sub_category.dart';
import '../util/app_constants.dart';
import 'authorization_service.dart';

class SubCategoryService{

  Future<SubCategory> getSubCatById(int subCategoryId) async {
    print('CALLLEDDDDDD');
    final response = await get(
        Uri.parse('${AppConstants.api}/sub_category/$subCategoryId?populate=true'));
    print('CHECKING SUBCATEGORY: ${response.body}');
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      Map<String, dynamic> levelsJson = jsonData["data"];
      print('CHECKING JSON: ${levelsJson['levels']}');
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

  Future<List<SubCategory>> getPaidSubCategories() async {
    print('CALLLLLEDDDDDDDDDDD PAIDDDDDDDDD SUBBBBBBBBBBBBSSSSSSSSSSS');
    String? token = await AuthService.getAuthorizationToken();
    if(token == null) {
      return [];
    }
    final response = await get(
        Uri.parse('${AppConstants.api}/get_paid_courses'),
    headers: {
      'Authorization': 'Bearer $token'
    }
    );

    print('CHECKING PAID COURSES: ${response.body}');

    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<SubCategory> subcats = [];
      List<dynamic> dataList = jsonData['data'];
      for (var item in dataList) {
        for (var item in dataList) {
          var subcategory = SubCategory.fromJson(item['subcategory']);
          subcats.add(subcategory);
        }
      }
      return subcats;
    } else {
      throw Exception(response.statusCode);
    }
  }


}
