import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';

import '../../util/app_routes.dart';


class Footer extends StatelessWidget {

final bool isLogin;
  const Footer({
    super.key, required this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0, 12, 0, 12),
      child: GestureDetector(
        onTap: () {
          isLogin? Get.toNamed(AppRoutes.signup) : Get.toNamed(AppRoutes.login);
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: isLogin?'Don\'t have an account?  ' : 'Already have an account?  ',
                style: TextStyle(),
              ),
              TextSpan(
                text: isLogin? 'Sign Up here' : 'Log In here',
                style: FlutterFlowTheme.of(context)
                    .bodyMedium
                    .override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(
                      context)
                      .primary,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
            style: FlutterFlowTheme.of(context)
                .bodyMedium,
          ),
          textScaler: TextScaler.linear(
              MediaQuery.of(context)
                  .textScaleFactor),
        ),
      ),
    );
  }
}

