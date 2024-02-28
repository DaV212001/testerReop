// forgot_password_controller.dart

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../screen/auth/log_in.dart';
import '../service/user_service.dart';

class ResetPasswordController extends GetxController {
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

  final UserService _userService = UserService();
  Rx<Color> color = Colors.grey.obs;

  Future<void> resetPassword(String otp, String newPass, String phone) async {
    try {
      await _userService.resetPassword(otp, newPass, phone);
      // Password reset successful, navigate to login screen
      Get.offAll(const LogInWidget());
    } catch (e) {
      if (e.toString().contains('Invalid OTP')) {
        // Invalid OTP, change verification code color to red
        color.value = Colors.red;
      } else {
        // Other errors, show a snackbar
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          )
        );
        print('FAILLLLLLLLLLLLLLLLL=====================');
      }
    }
  }

  Rx<String> password = ''.obs;
  Rx<String> confirmpassword = ''.obs;
  Rx<String> phonenumber = ''.obs;
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
// Add your password reset logic here (e.g., API calls, email sending, etc.)
}
