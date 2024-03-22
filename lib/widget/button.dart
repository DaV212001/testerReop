import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final bool hasLoader;
  final bool? agreedToTerms;
  const Button(
      {super.key,
      required this.text,
      required this.onPress,
      this.hasLoader = true, this.agreedToTerms});

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: onPress,
      text: text,
      showLoadingIndicator: hasLoader,
      options: FFButtonOptions(
        width: double.infinity,
        height: 44,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        color: agreedToTerms != null? agreedToTerms == true? Color(0xFFFF2C20) : Colors.grey : Color(0xFFFF2C20),
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
