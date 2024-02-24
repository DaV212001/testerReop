import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';

import '../config_preference.dart';


class ThemeManager {
  static getThemeMode(){
    if(ConfigPreference.getThemeIsLight()){
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  /// update app theme and save theme type to shared pref
  /// (so when the app is killed and up again theme will remain the same)
  static changeTheme(){
    // *) check if the current theme is light (default is light)
    bool isLightTheme = ConfigPreference.getThemeIsLight();

    // *) store the new theme mode on get storage
    ConfigPreference.setThemeIsLight(!isLightTheme);

    // *) let GetX change theme
    Get.changeThemeMode(!isLightTheme ? ThemeMode.light : ThemeMode.dark);
  }

  /// check if the theme is light or dark
  static bool get getThemeIsLight => ConfigPreference.getThemeIsLight();
}