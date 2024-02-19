import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/post.dart';
import '../service/post_service.dart';

class PostController extends GetxController {
  final _listOfPosts = <Post>[].obs;

  List<Post> get getAllPosts => _listOfPosts.value;

  String errorMessage = 'Can\'t proceed request';
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;

  getPostsFromApi() async {
    try {
      _listOfPosts.clear();
      _isLoading.value = true;

      final response = await PostService.fetchPosts();
      _listOfPosts.addAll(response);

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
    getPostsFromApi();
  }

}