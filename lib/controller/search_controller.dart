import 'package:get/get.dart';
import 'package:mss_e_learning/model/category.dart';
import 'package:mss_e_learning/model/lesson.dart';
import 'package:mss_e_learning/model/sub_category.dart';
import '../service/search_services.dart';

class SearchControllerr extends GetxController {
  final SearchService _searchService = SearchService();

  final categories = <Category>[].obs;
  final subcategories = <SubCategory>[].obs;
  final lessons = <Lesson>[].obs;

  Future<void> getSearchData(String searchName) async {
    try {
      final List searchData = await _searchService.getSearchData(searchName);
      categories.assignAll(searchData[0] as List<Category>);
      subcategories.assignAll(searchData[1] as List<SubCategory>);
      lessons.assignAll(searchData[2] as List<Lesson>);
    }
    catch (e) {
      print('Error fetching search data: $e');
    }

}
}
