import 'package:flutter/material.dart';

class AppConstants {
  static const String api = "https://api.techsavvyadademia.com/api";
  static const String imagebaseurl = "https://api.techsavvyadademia.com/public/storage/";
  static const int subcatid = 17;
  static const Color primary = Color(0xFF4B39EF);
  static const String authStorage = 'dsa_authorization_token';
  static const String packageName = 'com.msslearn.data_science_and_analytics';
  static const String appName = 'Data Science And Analytics';
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