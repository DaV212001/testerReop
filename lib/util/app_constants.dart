import 'package:flutter/material.dart';

class AppConstants {
  static const String api = "https://api.techsavvyadademia.com/api";
  static const String imagebaseurl = "https://api.techsavvyadademia.com/public/storage/";
  static const int subcatid = 26;
  static const Color primary = Color(0xFF4B39EF);
  static const String authStorage = 'fsd_authorization_token';
  static const String packageName = 'com.msslearn.full_stack_development';
  static const String appName = 'Fullstack Development';
  static const String headerAppName = 'Tech Savvy';
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