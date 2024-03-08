import 'package:flutter/material.dart';

class AppConstants {
  static const String api = "https://learning.bhwethiopia.com/api";
  static const String imagebaseurl = "https://learning.bhwethiopia.com/public/storage/";
  static var kAuthContainerGradient = const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF4B39EF),
        Color(0xFFEE8B60)
      ],
      stops: [0, 1],
      begin: AlignmentDirectional(0.87, -1),
      end: AlignmentDirectional(-0.87, 1),
    ),
  );
}