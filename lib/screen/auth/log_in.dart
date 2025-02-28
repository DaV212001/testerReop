import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/layout/auth/footer.dart';
import 'package:mss_e_learning/service/user_service.dart';
import 'package:mss_e_learning/util/app_constants.dart';
import 'package:mss_e_learning/util/app_routes.dart';
import 'package:mss_e_learning/controller/log_in_controllers.dart';
import 'package:mss_e_learning/widget/button.dart';
import '../../model/user.dart';
import '../../widget/input_field.dart';
export 'package:mss_e_learning/controller/log_in_controllers.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({super.key});

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget>
    with TickerProviderStateMixin {
  late LogInModel _model;

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
    _model = createModel(context, () => LogInModel());

    _model.emailAddressController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

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
        body: Container(
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
                    width: 287,
                    height: 102,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: const AlignmentDirectional(0, 0),
                    child: Text(
                      AppConstants.headerAppName,
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                            fontFamily: 'Outfit',
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
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
                    child: buildBody(context),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align buildBody(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome Back',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).displaySmall,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
              child: Text(
                'Fill out the information below in order to access your account.',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).labelMedium,
              ),
            ),
            buildForm(context),

            const Footer(isLogin: true),
          ],
        ),
      ),
    );
  }

  Column buildForm(BuildContext context) {
    return Column(
      children: [
        InputFieldWidget(
            textEditingController: _model.emailAddressController!,
            focusNode: _model.emailAddressFocusNode!,
            validator: (val) {
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
            return null;
          },
        ),
        Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.forgotpass);
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 16),
                child: Text(
                    'Forgot Password?',
                    textAlign: TextAlign.end,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      color: FlutterFlowTheme.of(context).primary,
                      fontWeight: FontWeight.w500,
                    )
                ),
              ),
            )
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
          child: Button(
            onPress: () async {
              UserService userservice = UserService();

              try {
                User user = await userservice.logUserIn(_model.emailAddressController.text, _model.passwordController.text);
                Get.toNamed(AppRoutes.initial);
              } on Exception catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString().replaceFirst('Exception: ', 'Error: ')),
                  )
                );
              }
              setState(() {});

            },
            text: 'Sign In',
          ),
        ),
      ],
    );
  }
}
