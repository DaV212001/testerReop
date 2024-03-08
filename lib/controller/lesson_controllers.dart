import 'package:get/get.dart';
import 'package:mss_e_learning/model/error_data.dart';
import 'package:mss_e_learning/service/bookmark_services.dart';
import 'package:mss_e_learning/util/api_call_status.dart';
import 'package:mss_e_learning/util/error_util.dart';
import 'package:mss_e_learning/widget/custom_snackbar.dart';

import '../model/bookmark.dart';
import '../model/level.dart';
import '../service/lesson_service.dart';

class LessonController extends GetxController {
  final _listOfLevel = <Level>[].obs;

  RxString subCategoryId = RxString("");

  List<Level> get listOfAllLevels => _listOfLevel.value;

  final errorData = ErrorData(title: "", body: "", image: "").obs;
  final status = ApiCallStatus.holding.obs;

  final _isBookmarkLoading = false.obs;
  Rx<bool> isBookMarked=false.obs;


  checkIfBookMarked(int lessonId) async {
    try {
      List<BookMark> bookmarks = await BookMarkServices.fetchBookmarksAllAtOnce();
      print('AMOUNT OF BOOKMARKS: ${bookmarks.length}');
      bookmarks.forEach((element) {
        if(element.lessons?.id == lessonId){
          isBookMarked.value = true;
        }
      });
    } on Exception catch (error) {
      errorData.value = ErrorUtil.getErrorData(error.toString());
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error Occured', message: 'Could not check if lesson was bookmarked');
    }
  }


  get isBookmarkLoading => _isBookmarkLoading.value;

  getLevels(String subCategoryId) async {
    try {
      _listOfLevel.clear();
      status.value = ApiCallStatus.loading;

      final response = await LessonService.fetchLevelsById(subCategoryId);
      _listOfLevel.addAll(response);

      status.value = ApiCallStatus.success;
    } on Exception catch (fetchError) {
      status.value = ApiCallStatus.error;
      errorData.value = ErrorUtil.getErrorData(fetchError.toString());
    }
  }

  Future<bool> bookmarkLesson(int lessonId) async {
    try {
      _isBookmarkLoading.value = true;
      var response = await LessonService.addBookmarkLesson(lessonId);
      isBookMarked.value = true;
      return response.statusCode == 200;
    } on Exception catch (error) {
      errorData.value = ErrorUtil.getErrorData(error.toString());
      CustomSnackBar.showCustomErrorSnackBar(
          title: errorData.value.title, message: errorData.value.body);
      _isBookmarkLoading.value = false;
      return false;
    }
  }

  Future<bool> unBookmarkLesson(int lessonId) async {
    try {
      _isBookmarkLoading.value = true;
      var response = await LessonService.deleteBookmarkLesson(lessonId);
      isBookMarked.value = false;
      return response.statusCode == 200;
    } on Exception catch (error) {
      errorData.value = ErrorUtil.getErrorData(error.toString());
      CustomSnackBar.showCustomErrorSnackBar(
          title: errorData.value.title, message: errorData.value.body);
      _isBookmarkLoading.value = false;
      return false;
    }
  }



  @override
  void onInit() {
    super.onInit();
    // getLevels();
  }
}
