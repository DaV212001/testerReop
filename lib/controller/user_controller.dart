import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/service/user_service.dart';

import '../model/user.dart';

class UserController extends GetxController {
  static Rx<User?> user = Rx<User?>(null);
  bool hasFetchedUser = false;

  Future<void> fetchUser(String token) async {
    if (!hasFetchedUser) {
      try {
        final userResponse = await UserService().getUser(token);
        if(userResponse.firstname == null){
          user.value = User(firstname: 'Guest');
        }
        user.value = userResponse;
        hasFetchedUser = true;
      } catch (e) {
        // Handle API call error (show error message, etc.)
        print('Error fetching user: $e');
      }
    }
  }
}