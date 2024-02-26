import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/layout/password/header_image_and_text.dart';
import 'package:mss_e_learning/screen/main_layout_screen.dart';
import 'package:mss_e_learning/util/app_constants.dart';
import 'package:mss_e_learning/widget/input_field.dart';
import '../../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {


  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

bool hideOldPassword = true;
bool hideNewPassword = true;

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(),
        builder: (controller) {
          return Form(
            child: Container(
              height: double.infinity,
              decoration: AppConstants.KauthContainerGradient,
              alignment: const AlignmentDirectional(0, -1),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const HeaderImageAndText(
                          imagePath:
                              'assets/images/illustrations/reset_password.svg',
                          headerText: 'Change password'),
                      const SizedBox(
                        height: 10,
                      ),
                      buildBody(context).animateOnPageLoad(
                          ChangePasswordController()
                              .animationsMap['textOnPageLoadAnimation']!),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildBody(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 570,
      ),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter both the current and the new password. You will be logged out after you change your password.',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ).animateOnPageLoad(ChangePasswordController()
                      .animationsMap['containerOnPageLoadAnimation1']!),
                  buildForm(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: FlutterFlowTheme.of(context).primary),
                    onPressed: () {
                      // TODO: Implement password reset logic here
                      Get.to(const MainLayoutScreen());
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ])),
      ),
    );
  }

  Column buildForm() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: InputFieldWidget(
                textEditingController:
                    ChangePasswordController().oldPasswordController,
                focusNode: ChangePasswordController().oldPasswordFocusNode,
                obscureText: hideOldPassword,
                validator: (val) {
                  return null;
                },
                passwordinput: true,
                label: "Old password")),
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: InputFieldWidget(
                textEditingController:
                    ChangePasswordController().newPasswordController,
                focusNode: ChangePasswordController().newPasswordFocusNode,
                obscureText: hideNewPassword,
                validator: (val) {
                  if (val!.length < 8) {
                    return 'Password must be 8 characters.';
                  }
                  return null;
                },
                passwordinput: true,
                label: "New password")),
      ],
    );
  }
}
