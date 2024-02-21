import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Get Started',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context)
              .displaySmall,
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
              0, 12, 0, 24),
          child: Text(
            'Let\'s get started by filling out the form below.',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context)
                .labelLarge,
          ),
        ),
      ],
    );
  }
}