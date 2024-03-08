import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FFButtonWidget(
          onPressed: onTap,
          text: 'Load More',
          icon: Icon(FontAwesomeIcons.arrowDown),
          options: FFButtonOptions(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
              color: FlutterFlowTheme.of(context).secondary,
              textStyle: FlutterFlowTheme.of(context)
                  .titleSmall
                  .override(
                  fontFamily: 'Poppins',
                  color:
                  FlutterFlowTheme.of(context).primaryText)),
        )
    );
  }
}
