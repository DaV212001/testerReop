import 'package:get/get.dart';
import 'package:mss_e_learning/model/error_data.dart';
import 'package:mss_e_learning/service/category_service.dart';
import 'package:mss_e_learning/util/api_call_status.dart';
import 'package:mss_e_learning/util/error_util.dart';

import '../model/category.dart';


class CategoryController extends GetxController {
  final _listOfCategory = <Category>[].obs;

  List<Category> get listOfAllCategories => _listOfCategory;

  final errorData = ErrorData(title: "", body: "", image: "").obs;
  final status = ApiCallStatus.holding.obs;


  getCategories() async {
    try {
      _listOfCategory.clear();
      status.value = ApiCallStatus.loading;

      final response = await CategoryService.fetchCategories();
      _listOfCategory.addAll(response);

      status.value = ApiCallStatus.success;
    } on Exception catch (fetchError) {
      status.value = ApiCallStatus.error;
      errorData.value = ErrorUtil.getErrorData(fetchError.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

}