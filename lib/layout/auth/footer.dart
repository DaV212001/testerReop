import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';


class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0, 12, 0, 12),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account?  ',
              style: TextStyle(),
            ),
            TextSpan(
              text: 'Sign Up here',
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
    );
  }
}

