// forgot_password_controller.dart

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
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
  Rx<String> oldPassword = ''.obs;
  Rx<String> newPassword = ''.obs;


  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode oldPasswordFocusNode = FocusNode();
// Add your password change logic here (e.g., API calls, email sending, etc.)
}
