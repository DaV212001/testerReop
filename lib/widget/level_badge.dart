import 'package:flutter/cupertino.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mss_e_learning/model/lesson_description.dart';
import '../model/lesson.dart';



class LevelBadge extends StatelessWidget {
  const LevelBadge({
    super.key,
    required this.lesson,
  });

  final LessonDescription? lesson;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              FlutterFlowTheme.of(context).primary,
              FlutterFlowTheme.of(context).tertiary
            ],
            stops: [0, 1],
            begin: AlignmentDirectional(0.87, -1),
            end: AlignmentDirectional(-0.87, 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            lesson!.title!,
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).bodyLarge,
          ),
        ),
      ),
    );
  }
}


