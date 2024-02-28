// forgot_password_controller.dart

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../service/user_service.dart';

class ForgotPasswordController extends GetxController {
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
  Rx<String> email = ''.obs;

  final UserService _userService = UserService();

  Future<void> sendOtp(String emailOrPhone) async {
    try {
      await _userService.sendOTP(emailOrPhone);
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('OTP sent, please check your email'),
          )
      );
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Failed to send OTP'),
        ),
      );
    }
  }
  FocusNode emailFocusNode = FocusNode();

// Add your password reset logic here (e.g., API calls, email sending, etc.)
}
