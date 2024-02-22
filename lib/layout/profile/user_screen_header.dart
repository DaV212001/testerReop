import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mss_e_learning/model/user.dart';
import 'package:mss_e_learning/widget/profile_widget.dart';

class UserScreenHeader extends StatefulWidget {
  final User user;

  const UserScreenHeader({super.key, required this.user});

  @override
  State<UserScreenHeader> createState() => _UserScreenHeaderState();
}

class _UserScreenHeaderState extends State<UserScreenHeader> {
  final double coverHeight = 210.h;
  final double imageHeight = 144.w;
  final picker = ImagePicker();
  late var profilePicture;
  bool isFile = false;

  @override
  void initState() {
    profilePicture = widget.user.profilePicture;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    String firstName = widget.user.firstName;
    String lastName = widget.user.lastName;
    String formattedName =
        "${firstName[0].toUpperCase()}${firstName.substring(1).toLowerCase()}"
        " ${lastName[0].toUpperCase()}${lastName.substring(1).toLowerCase()}";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileWidget(
          imagePath: profilePicture,
          hasEditButton: false,
          isFile: isFile,
          onClicked: showOptions,
        ),
        SizedBox(height: 5.h),
        Text(formattedName,
            style: TextStyle(color: theme.primaryColor, fontSize: 20.sp)),
        SizedBox(height: 5.h),
        Text("${widget.user.email}",
            style:
                TextStyle(color: theme.colorScheme.tertiary, fontSize: 15.sp)),
        SizedBox(height: 15.h),
      ],
    );
  }

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        profilePicture = File(pickedFile.path);
        isFile = true;
        // updatePicture();
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        profilePicture = File(pickedFile.path);
        isFile = true;
        // updatePicture();
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              'Photo Gallery',
              style: TextStyle(fontSize: 20.sp),
            ),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Camera',
              style: TextStyle(fontSize: 20.sp),
            ),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
}
