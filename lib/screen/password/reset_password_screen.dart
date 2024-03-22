import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/layout/password/header_image_and_text.dart';
import 'package:mss_e_learning/util/app_constants.dart';
import 'package:mss_e_learning/widget/input_field.dart';
import '../../controller/forgot_password_controller.dart';
import '../../controller/reset_password_controller.dart';
import '../../widget/verification_code_entry_widget.dart';
import '../auth/log_in.dart';

class ResetPasswordScreen extends StatefulWidget {

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

bool hidePassword = true;
bool hideConfirmPassword = true;

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
TextEditingController phoneController = TextEditingController(text: ResetPasswordController().phonenumber.value);
  TextEditingController passwordController = TextEditingController(text: ResetPasswordController().password.value);
  TextEditingController confirmPasswordController = TextEditingController(text: ResetPasswordController().confirmpassword.value);
String verificationCode = '';
ResetPasswordController controller = Get.put(ResetPasswordController());
Color color = Colors.grey;
bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) {
          return Form(
            child: Container(
              height: double.infinity,
              decoration: AppConstants.kAuthContainerGradient,
              alignment: const AlignmentDirectional(0, -1),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const HeaderImageAndText(
                          imagePath:
                              'assets/images/illustrations/reset_password.svg',
                          headerText: 'Reset Password', showbackButton: false,),
                      const SizedBox(
                        height: 10,
                      ),
                      buildBody(context).animateOnPageLoad(
                          ResetPasswordController()
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
                    'Enter the verification code we sent to your email and your new password along with your phone number.',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).labelMedium,
                  ).animateOnPageLoad(ResetPasswordController()
                      .animationsMap['containerOnPageLoadAnimation1']!),
                  buildForm(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color(0xFFFF2C20)),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      print(loading);
                      if(errormessage != 'full'){
                        if(errormessage == ''){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter verification code')));
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errormessage)));
                        return;
                      }
                      await controller.resetPassword(verificationCode, controller.password.value, controller.phonenumber.value);
                      setState(() {
                        loading = false;
                      });
                      print(loading);
                    },
                    child:loading? CircularProgressIndicator(color: Colors.white,): Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ])),
      ),
    );
  }
String errormessage = '';
  Column buildForm() {
    return Column(
      children: [
        CustomSixDigitVerificationCodeInput(
            onCodeChanged: (code) {
              if(code.length == 6){
                setState(() {
                  errormessage = 'full';
                });
                verificationCode = code;
              } else {
                setState(() {
                  errormessage = 'Verification code needs to be 6 digits';
                });
              }
              print("New code: $code");
            },
          color: controller.color.value,),
        if(errormessage != 'full')Text(errormessage, style: TextStyle(color: Colors.red),),
        Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: InputFieldWidget(
                textEditingController: passwordController,
                focusNode: null,
                obscureText: hidePassword,
                onChanged: (val) {
                  controller.password.value = val!;
                  return null;
                },
                validator: (val) {
                  if (val!.length < 8) {
                    return 'Password must be 8 characters.';
                  }
                  return null;
                },
                passwordinput: true,
                label: "New password")
        ),
        Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: InputFieldWidget(
                textEditingController: confirmPasswordController,
                focusNode: ResetPasswordController().confirmPasswordFocusNode,
                obscureText: hideConfirmPassword,
                onChanged: (val) {
                  controller.confirmpassword.value = val!;
                  return null;
                },
                validator: (val) {
                  if (val != passwordController.text) {
                    return 'Passwords must match.';
                  }
                  return null;
                },
                passwordinput: true,
                label: "Confirm password")
        ),
        Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: InputFieldWidget(
                textEditingController: phoneController,
                focusNode: null,
                obscureText: hideConfirmPassword,
                hint: '09********',
                maxlength: 10,
                onChanged: (val) {
                  controller.phonenumber.value = val!;
                  return null;
                },
                validator: (val) {
                  if (val!.length<10) {
                    return 'Phone number needs to be atleast 10 digits.';
                  }
                  return null;
                },
                passwordinput: false,
                label: "Enter phone number")
        ),
      ],
    );
  }
}
