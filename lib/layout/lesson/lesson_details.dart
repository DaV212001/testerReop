import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mss_e_learning/layout/lesson/lesson_pdf.dart';
import 'package:mss_e_learning/layout/lesson/lesson_video.dart';
import 'package:mss_e_learning/model/lesson_description.dart';
import 'package:mss_e_learning/service/lesson_service.dart';
import 'package:mss_e_learning/controller/lesson_description_controllers.dart';

import 'header_image_and_buttons.dart';
export 'package:mss_e_learning/controller/lesson_description_controllers.dart';

class LessonDetailScreen extends StatefulWidget {
  final int lessonId;
  const LessonDetailScreen({super.key, required this.lessonId});

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen>
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
  }

  LessonDescription? lesson;

  void getLesson() async {
    LessonService lessonService = LessonService();
    lesson = await lessonService.fetchLessonById(widget.lessonId.toString());
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
    ThemeData theme = Theme.of(context);
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return DefaultTabController(
        length: 3,
        child: !loaded
            ? const Padding(
          padding: EdgeInsets.all(50.0),
          child: Center(child: CircularProgressIndicator()),
        )
            :Scaffold(
            body: NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                        title: Text(lesson!.title),
                        pinned: true,
                        floating: true,
                        bottom: TabBar(
                            isScrollable: true,
                            tabs: [
                              Tab(child: Text('Lessons',
                                  style: theme.textTheme.labelLarge)),
                              Tab(child: Text('PDFs',
                                  style: theme.textTheme.labelLarge)),
                              Tab(child: Text('Videos',
                                  style: theme.textTheme.labelLarge))
                            ]
                        )
                    )
                  ];
                },
                body: TabBarView(
                    children: <Widget>[
                      GestureDetector(
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
                                  ? const Padding(
                                padding: EdgeInsets.all(50.0),
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
                      ),
                      PdfScreen(lesson: lesson),
                      VideoScreen(lesson: lesson)
                    ]
                )
            ))
    );
  }


  Column buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       HeaderImageAndButtons(lesson: lesson).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
          child: Text(
            lesson!.title,
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
              )
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

