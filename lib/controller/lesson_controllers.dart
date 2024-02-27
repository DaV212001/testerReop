import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/level.dart';
import '../service/lesson_service.dart';


class LessonController extends GetxController {
  final _listOfLevel = <Level>[].obs;

  RxString subCategoryId = RxString("");

  List<Level> get listOfAllLevels => _listOfLevel.value;

  String errorMessage = 'Can\'t proceed request';
  final _isLoading = false.obs;

  final _isBookmarkLoading = false.obs;

  get isBookmarkLoading => _isBookmarkLoading.value;
  get isLoading => _isLoading.value;

  getLevels(String subCategoryId) async {
    print("here==============================================");
    print(subCategoryId);
    print("here==============================================");

    try {
      _listOfLevel.clear();
      _isLoading.value = true;
      final response = await LessonService.fetchLevelsById(subCategoryId);
      _listOfLevel.addAll(response);
    } on HttpException catch (error) {
      if (error.toString().contains('Redirection error')) {
        errorMessage = 'The resource requested has been temporarily moved.';
      } else if (error.toString().contains('Bad Request Format')) {
        errorMessage = 'Your client has issued a malformed or illegal request.';
      } else if (error.toString().contains('Internal Server Error')) {
        errorMessage =
        'The server encountered an error and could not complete your request.';
      } else if (error.toString().contains('No Internet Found')) {
        errorMessage =
        'There is no or poor internet connect. Please try again later';
      }
      showSnackBar(errorMessage);
    }
    _isLoading.value = false;
  }
  Future<bool> bookmarkLesson(int lessonId) async {
    try {
      print("loading");
      _isBookmarkLoading.value = true;
      var response = await LessonService.addBookmarkLesson(lessonId);
      return response.statusCode == 200;
    } on HttpException catch (error) {
      if (error.toString().contains('Redirection error')) {
        errorMessage = 'The resource requested has been temporarily moved.';
      } else if (error.toString().contains('Bad Request Format')) {
        errorMessage = 'Your client has issued a malformed or illegal request.';
      } else if (error.toString().contains('Internal Server Error')) {
        errorMessage =
        'The server encountered an error and could not complete your request.';
      } else if (error.toString().contains('No Internet Found')) {
        errorMessage =
        'There is no or poor internet connect. Please try again later';
      }
      _isBookmarkLoading.value = false;
      return false;
    }
  }

  showSnackBar(var message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  showSuccessSnackBar(var message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  @override
  void onInit() {
    super.onInit();
    // getLevels();
  }

}