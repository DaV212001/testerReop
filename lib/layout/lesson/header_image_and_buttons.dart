import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:mss_e_learning/model/lesson_description.dart';

import '../../model/lesson.dart';


class HeaderImageAndButtons extends StatelessWidget {
  const HeaderImageAndButtons({
    super.key,
    required this.lesson,
  });

  final LessonDescription? lesson;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 330,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.network(
            lesson!.image,
          ).image,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Color(0x17202529),
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 36, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // FlutterFlowIconButton(
                //   borderColor: Colors.transparent,
                //   borderRadius: 30,
                //   borderWidth: 1,
                //   buttonSize: 40,
                //   fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                //   icon: Icon(
                //     Icons.arrow_back_ios_rounded,
                //     color: FlutterFlowTheme.of(context).primaryText,
                //     size: 20,
                //   ),
                //   onPressed: () async {
                //     Navigator.pop(context);
                //   },
                // ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [

                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 40,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.keyboard_control_outlined,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}