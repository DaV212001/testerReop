import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mss_e_learning/model/user.dart';
import 'package:mss_e_learning/widget/profile_widget.dart';

class UserScreenHeader extends StatefulWidget {
  final User user;

  const UserScreenHeader({ required this.user});

  @override
  State<UserScreenHeader> createState() => _UserScreenHeaderState();
}

class _UserScreenHeaderState extends State<UserScreenHeader> {
  final double coverHeight = 210;
  final double imageHeight = 144;
  final picker = ImagePicker();
  late dynamic profilePicture;
  bool isFile = false;

  @override
  void initState() {
    profilePicture = widget.user.profilepicture;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    String firstName = widget.user.firstname ?? "";
    String lastName = widget.user.lastname ?? "";
    String formattedName =
        "${firstName[0].toUpperCase()}${firstName.substring(1).toLowerCase()}"
        " ${lastName[0].toUpperCase()}${lastName.substring(1).toLowerCase()}";

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileWidget(
          imagePath: profilePicture,
          hasEditButton: false,
          isFile: isFile,
          onClicked: showOptions,
        ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formattedName,
                style:theme.headlineSmall.copyWith(
                    color: Color(0xFFFF2C20)
                )),
            const SizedBox(height: 5),
            Text("${widget.user.email}",
                style: theme.bodyMedium.copyWith(
                  color: Color(0xFFFF2C20).withOpacity(0.5)
                )),
          ],
        ),
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
            child: const Text(
              'Photo Gallery',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Camera',
              style: TextStyle(fontSize: 20),
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
