import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mss_e_learning/screen/lesson/lesson_screen.dart' show SubCategoryDetailScreen;
import 'package:flutter/material.dart';


class CourseDetailModel extends FlutterFlowModel<SubCategoryDetailScreen> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
