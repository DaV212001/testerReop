// forgot_password_controller.dart

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../service/user_service.dart';

class ChangeProfileController extends GetxController {
  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 100.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 100.ms,
          duration: 600.ms,
          begin: Offset(0, 170),
          end: Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
  };

  Rx<String> firstname = ''.obs;
  Rx<String> lastname = ''.obs;

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();

  final UserService _userService = UserService();

  Future<void> updateUser(String firstName, String lastName) async {
    try {
      await _userService.updateUser(firstName, lastName);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
        )
      );
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile'),
        ),
      );
    }
  }
}
