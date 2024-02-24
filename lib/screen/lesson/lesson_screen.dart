import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/model/lesson.dart';
import 'package:mss_e_learning/service/lesson_service.dart';
import 'package:mss_e_learning/controller/lesson_controllers.dart';

import '../../layout/lesson/header_image_and_buttons.dart';
import '../../widget/level_badge.dart';
export 'package:mss_e_learning/controller/lesson_controllers.dart';

class LessonScreen extends StatefulWidget {
  final int lessonId;
  const LessonScreen({super.key, required this.lessonId});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with TickerProviderStateMixin {
  late CourseDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

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
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, -250),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  bool loaded = false;
  @override
  void initState() {
    super.initState();
    getLesson();
    _model = createModel(context, () => CourseDetailModel());
  }

  Lesson? lesson;

  void getLesson() async {
    LessonService lessonService = LessonService();
    lesson = await lessonService.fetchLesson(widget.lessonId);
    if (lesson != null) {
      setState(() {
        loaded = true;
      });
    }
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            !loaded
                ? Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildHeader(context),
                          Divider(
                            height: 32,
                            thickness: 1,
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                          buildBody(context)
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }


  Column buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderImageAndButtons(lesson: lesson).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
          child: Text(
            lesson!.subcategory.name,
            style: FlutterFlowTheme.of(context).displaySmall,
          ),
        ),
      ],
    );
  }


  Column buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 4, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lesson!.title,
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).headlineMedium,
              ),
              LevelBadge(lesson: lesson),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 12, 0, 0),
          child: Text(
            'Lesson Details',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 12),
          child: Text(
            lesson!.description,
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).labelMedium,
          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
        ),
      ],
    );
  }
}

