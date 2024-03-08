// sub_category_controller.dart

import 'package:get/get.dart';
import 'package:mss_e_learning/service/sub_category_service.dart';

import '../model/error_data.dart';
import '../model/sub_category.dart';
import '../util/api_call_status.dart';
import '../util/error_util.dart';

class SubCategoryController extends GetxController {
  final SubCategoryService _subCategoryService = SubCategoryService();
  final RxList<SubCategory> subCategories = <SubCategory>[].obs;
  final RxList<SubCategory> filteredSubCategories = <SubCategory>[].obs;
  final errorData = ErrorData(title: "", body: "", image: "").obs;
  final status = ApiCallStatus.holding.obs;


  @override
  void onInit() {
    super.onInit();
    fetchSubCategories();
  }

  Future<void> fetchSubCategories() async {
    print('CALLEDDDD');
    status.value = ApiCallStatus.loading;
    try {
      final List<SubCategory> fetchedSubCategories = await _subCategoryService.getSubCategories();
      subCategories.assignAll(fetchedSubCategories);
      filteredSubCategories.assignAll(fetchedSubCategories); // Initialize filtered list
      status.value = ApiCallStatus.success;
    } on Exception catch (fetchError) {
      status.value = ApiCallStatus.error;
      errorData.value = ErrorUtil.getErrorData(fetchError.toString());
    }
  }

  void filterSubCategories(String query) {
    if (query.isEmpty) {
      filteredSubCategories.assignAll(subCategories);
    } else {
      filteredSubCategories.assignAll(subCategories
          .where((subCategory) =>
          subCategory.name!.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }
}
