import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/layout/password/header_image_and_text.dart';
import 'package:mss_e_learning/screen/password/reset_password_screen.dart';
import 'package:mss_e_learning/screen/password/verification_screen.dart';
import 'package:mss_e_learning/util/app_constants.dart';
import 'package:mss_e_learning/widget/input_field.dart';
import '../../controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {


  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}



class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController(text: ForgotPasswordController().email.value);

ForgotPasswordController controller = Get.put(ForgotPasswordController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) {
          return  Form(
            child: Container(
              height: double.infinity,
              decoration: AppConstants.kAuthContainerGradient,
              alignment: const AlignmentDirectional(0, -1),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const HeaderImageAndText(
                          imagePath: 'assets/images/illustrations/forgot_password.svg',
                          headerText: 'Forgot password?', showbackButton: true,
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
bool loading = false;
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
                                'Enter your email or phone number and we will send a 6 digit code to your account ',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ).animateOnPageLoad(ForgotPasswordController().animationsMap['containerOnPageLoadAnimation1']!),
                              Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: InputFieldWidget(
                                    textEditingController: emailController,
                                    focusNode: null,
                                    obscureText: false,
                                    // hint: '09********',
                                    onChanged: (val){
                                      controller.email.value = val!;
                                      return null;
                                    },
                                    validator: (val){
                                      // if(val!.length < 10 ){
                                      //   return 'Phone number must be at least 10 digits';
                                      // }
                                      // if(val.startsWith('09')){
                                      //   return 'Phone number must start with 09';
                                      // }
                                      return null;
                                    },
                                    passwordinput: false,
                                    label: 'Email or phone number',
                                  prefixIcon: Icon(
                                    Icons.perm_contact_cal_rounded,
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
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  await controller.sendOtp(controller.email.value);
                                  setState(() {
                                    loading = false;
                                  });
                                  Get.to(() => ResetPasswordScreen());
                                },
                                child: loading? const CircularProgressIndicator(color: AppConstants.primary,) : const Text(
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
