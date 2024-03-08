// forgot_password_controller.dart

import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mss_e_learning/controller/user_controller.dart';
import 'package:mss_e_learning/service/authorization_service.dart';

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


  Rx<File?> profilePicture = Rx<File?>(null);

  Future<void> pickProfilePicture() async {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text(
              'Photo Gallery',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () async {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                profilePicture.value = File(pickedFile.path);
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Camera',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () async{
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                profilePicture.value = File(pickedFile.path);
              }
            },
          ),
        ],
      ),
    );
  }




  Future<void> updateUser(String firstName, String lastName, File profilePicture) async {
    print(firstName);
    try {
      if(firstname == '') {
        await _userService.updateUser(UserController.user.value!.firstname!, lastName,  profilePicture);
      }
      else if(lastname == '') {
        await _userService.updateUser(firstName, UserController.user.value!.lastname!, profilePicture);
      }
      else {
        await _userService.updateUser(firstName, lastName, profilePicture);
      }
      String? token = await AuthService.getAuthorizationToken();
      if(token != null) {
        UserController().fetchUser(token);
      }
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
