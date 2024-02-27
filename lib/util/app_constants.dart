import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
class AppConstants {
  static const String exampleAPI = "https://learning.bhwethiopia.com/api";
  static const String exampleAPI = "https://dummyjson.com";
  static var KauthContainerGradient = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        const Color(0xFF4B39EF),
        const Color(0xFFEE8B60)
      ],
      stops: const [0, 1],
      begin: const AlignmentDirectional(0.87, -1),
      end: const AlignmentDirectional(-0.87, 1),
    ),
  );
}