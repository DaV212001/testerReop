// forgot_password_screen.dart

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import '../../controller/forgot_password_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String id = 'forgot-password';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

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

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ForgotPasswordController>(
        init: ForgotPasswordController(),
        builder: (controller) {
          return Form(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Icon(
                      Icons.lock,
                      color: Colors.black,
                      size: 70,
                    ),
                  ),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold ),
                    textAlign: TextAlign.center,
                  ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),

                  Text(
                    'We will send an email to your account',
                    style: TextStyle(fontSize: 20, color: Colors.black, ),
                    textAlign: TextAlign.center,
                  ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(
                            Icons.email,
                          color: Colors.black,
                        ),
                        labelStyle: FlutterFlowTheme.of(context).labelLarge,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Send Email', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      backgroundColor: const Color(0XFF725AC1)
                    ),
                    onPressed: () {
                      // TODO: Implement password reset logic here
                    },
                  ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
