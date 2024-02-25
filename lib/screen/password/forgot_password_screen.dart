// forgot_password_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/layout/password/header_image_and_text.dart';
import 'package:mss_e_learning/screen/password/verification_screen.dart';
import 'package:mss_e_learning/util/app_constants.dart';
import 'package:mss_e_learning/widget/input_field.dart';
import 'package:mss_e_learning/widget/svg_icon.dart';
import '../../controller/forgot_password_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String id = 'forgot-password';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}



class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) {
          return  Form(
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
                          imagePath: 'assets/images/illustrations/forgot_password.svg',
                          headerText: 'Forgot password?'
                      ),
                const SizedBox(height: 10,),
                      buildBody(context).animateOnPageLoad(ForgotPasswordController().animationsMap['textOnPageLoadAnimation']!),

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
                                'We will send an email to your account',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ).animateOnPageLoad(ForgotPasswordController().animationsMap['containerOnPageLoadAnimation1']!),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: InputFieldWidget(
                                    textEditingController: ForgotPasswordController().emailController,
                                    focusNode: ForgotPasswordController().emailFocusNode,
                                    obscureText: false,
                                    validator: (val){
                                      if(!val!.isEmail){
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                    passwordinput: false,
                                    label: 'Email',
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                )
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: FlutterFlowTheme.of(context).primary
                                ),
                                onPressed: () {
                                  // TODO: Implement password reset logic here
                                  Get.to( () => VerificationScreen());
                                },
                                child: const Text(
                                  'Send Email',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),

                            ]
                          )
                        ),
                    ),
                    );
  }
}
