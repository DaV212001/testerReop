import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const Button({super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: onPress,
      text: text,
      options: FFButtonOptions(
        width: double.infinity,
        height: 44,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: FlutterFlowTheme.of(context).primary,
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
        elevation: 3,
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
