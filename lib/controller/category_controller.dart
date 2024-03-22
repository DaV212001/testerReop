import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mss_e_learning/model/error_data.dart';
import 'package:mss_e_learning/model/sub_category.dart';
import 'package:mss_e_learning/service/category_service.dart';
import 'package:mss_e_learning/service/sub_category_service.dart';
import 'package:mss_e_learning/util/api_call_status.dart';
import 'package:mss_e_learning/util/error_util.dart';

import '../model/category.dart';
import '../model/lesson.dart';
import '../model/promotion.dart';
import '../service/promotion_services.dart';


class CategoryController extends GetxController {


  final _listOfCategory = <Category>[].obs;

  List<Category> get listOfAllCategories => _listOfCategory;

  final errorData = ErrorData(title: "", body: "", image: "").obs;
  final status = ApiCallStatus.holding.obs;

  final _listOfPromotions = <Promotion>[].obs;
  List<Promotion> get listOfPromotions => _listOfPromotions;
  Rx<SubCategory> _subCategory = SubCategory().obs;
  SubCategory get subCategory => _subCategory.value;

  final _listOfAllLessons = <Lesson>[].obs;
  List<Lesson> get listOfAllLessons => _listOfAllLessons;


  getPromotions() async {
    try {
      _listOfPromotions.clear();
      status.value = ApiCallStatus.loading;

      final response = await PromotionServices.getPromotions(1);
      _listOfPromotions.addAll(response);

      status.value = ApiCallStatus.success;
    } on Exception catch (fetchError) {
      status.value = ApiCallStatus.error;
      errorData.value = ErrorUtil.getErrorData(fetchError.toString());
    }
  }

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


  getSubCategoryById(int subCategoryId) async {
    try {
      status.value = ApiCallStatus.loading;
      SubCategory response = await SubCategoryService().getSubCatById(
          subCategoryId);
      _subCategory.value = response;
      if(subCategory.levels !=null ){
      subCategory.levels?.forEach((element) {
        for(Lesson i in element.lessons){
          _listOfAllLessons.add(i);
        }
      });
      }
      status.value = ApiCallStatus.success;
      return response;
    } on Exception catch (fetchError) {
      status.value = ApiCallStatus.error;
      errorData.value = ErrorUtil.getErrorData(fetchError.toString());
    }
  }

  List<Lesson> getAlllessons(){
    if(subCategory.levels !=null ){
      subCategory.levels?.forEach((element) {
        for(Lesson i in element.lessons){
          _listOfAllLessons.add(i);
        }
      });
    }
    return listOfAllLessons;
  }

  @override
  void onInit() {
    super.onInit();
    getSubCategoryById(11);
    getPromotions();
    getCategories();
  }

}