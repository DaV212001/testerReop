import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mss_e_learning/screen/app_documentation/terms_and_conditions_screen.dart';
import 'package:mss_e_learning/service/user_service.dart';
import 'package:mss_e_learning/util/app_routes.dart';
import 'package:mss_e_learning/widget/button.dart';


import '../../layout/auth/footer.dart';
import '../../layout/auth/header.dart';
import '../../model/user.dart';
import '../../controller/sign_up_controllers.dart';
import '../../util/app_constants.dart';
import '../../widget/input_field.dart';
export '../../controller/sign_up_controllers.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget>
    with TickerProviderStateMixin {
  late SignUpModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: const Offset(0, 140),
          end: const Offset(0, 0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
        ),
        TiltEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: const Offset(-0.349, 0),
          end: const Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpModel());

    _model.firstnameController ??= TextEditingController();
    _model.firstnameFocusNode ??= FocusNode();

    _model.lastnameController ??= TextEditingController();
    _model.lastnameFocusNode ??= FocusNode();

    _model.emailAddressController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.phoneController ??= TextEditingController();
    _model.phoneFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }
bool agreedToTerms = false;
  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: 100,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primary,
                      FlutterFlowTheme.of(context).tertiary
                    ],
                    stops: const [0, 1],
                    begin: const AlignmentDirectional(0.87, -1),
                    end: const AlignmentDirectional(-0.87, 1),
                  ),
                ),
                alignment: const AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 32),
                        child: Container(
                          width: 284,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: const AlignmentDirectional(0, 0),
                          child: Text(
                            AppConstants.headerAppName,
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                      buildBody(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 570,
                        ),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
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
                                const Header(),
                                buildForm(context),
                                Padding(
                                  padding: const EdgeInsets.only(top: 18.0),
                                  child: CheckboxListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    value: agreedToTerms,
                                    onChanged: (value) {
                                      setState(() {
                                        agreedToTerms = value!;
                                      });
                                    },
                                    title: const Text("I agree with the terms and conditions",
                                        style: TextStyle(color: Colors.black)),
                                    controlAffinity: ListTileControlAffinity.leading, // add this line
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TermAndConditionScreen()));
                                    },
                                    child: const Center(
                                      child: Text(
                                          "Terms and Conditions",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Button(
                                    agreedToTerms: agreedToTerms,
                                    onPress: () async {
                                      if(agreedToTerms) {
                                        UserService userservice = UserService();

                                        if (_model.firstnameController!.text
                                            .length < 2 ||
                                            _model.lastnameController!.text
                                                .length < 2 ||
                                            !_model.emailAddressController!.text
                                                .isEmail ||
                                            _model.passwordController!.text
                                                .length < 8 ||
                                            _model.phoneController!.text
                                                .length < 10) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Please fill in all fields correctly.'),
                                          ));
                                          return;
                                        }

                                        User? userResult =
                                        await userservice.signUserUp(
                                          _model.firstnameController!.text,
                                          _model.lastnameController!.text,
                                          _model.emailAddressController!.text,
                                          _model.phoneController!.text,
                                          _model.passwordController!.text,
                                        );

                                        if (userResult.firstname == _model
                                            .firstnameController!.text) {
                                          Get.toNamed(AppRoutes.login);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Failed to Sign Up. Please try again.'),
                                            backgroundColor: Colors.red,
                                          ));
                                        }

                                        setState(() {});
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text(
                                              'Please agree to the terms and conditions.'
                                          )
                                        ));
                                      }
                                    },
                                    text: 'Create Account',
                                  ),
                                ),
                                const Footer(isLogin: false,),
                              ],
                            ),
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation']!),
                    );
  }

  Column buildForm(BuildContext context) {
    return Column(
      children: [
        InputFieldWidget(
            textEditingController: _model.firstnameController!,
            focusNode: _model.firstnameFocusNode!,
            validator: (val) {
              if (val!.length < 2) {
                return "First name must be atleast 2 characters.";
              }
              return null;
            },
            obscureText: false,
            passwordinput: false,
            label: 'First name'),
        InputFieldWidget(
            textEditingController: _model.lastnameController!,
            focusNode: _model.lastnameFocusNode!,
            validator: (val) {
              if (val!.length < 2) {
                return "Last name must be atleast 2 characters.";
              }
              return null;
            },
            obscureText: false,
            passwordinput: false,
            label: 'Last name'),
        InputFieldWidget(
            textEditingController: _model.emailAddressController!,
            focusNode: _model.emailAddressFocusNode!,
            validator: (val) {
              if (!val!.isEmail) {
                return "Enter a valid email.";
              }
              return null;
            },
            obscureText: false,
            passwordinput: false,
            label: 'Email'),
        InputFieldWidget(
            textEditingController: _model.passwordController!,
            focusNode: _model.passwordFocusNode!,
            passwordinput: true,
            obscureText: false,
            label: 'Password',
          validator: (val) {
            print("length ${val!.length}");
            if (val.length < 8) {
              return "Password must be atleast 8 characters.";
            }
            return null;
          },
        ),
        InputFieldWidget(
            textEditingController: _model.phoneController!,
            focusNode: _model.phoneFocusNode!,
            label: 'Phone number',
            validator: (val) {
              if (val!.length < 10) {
                return "Invalid Phone Number";
              }
              return null;
            },
            obscureText: false,
            passwordinput: false)
      ],
    );
  }
}


