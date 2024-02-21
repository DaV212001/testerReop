import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/screen/home/home_screen.dart';
import 'package:mss_e_learning/screen/main_layout_screen.dart';
import 'package:mss_e_learning/util/app_routes.dart';

import 'config/config_preference.dart';
import 'config/themes/data/app_themes.dart';
import 'config/themes/theme_manager.dart';

Future<void> main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();
  // init shared preference
  await ConfigPreference.init();

  runApp(const MssLearnProgramming());
}

class MssLearnProgramming extends StatelessWidget {
  const MssLearnProgramming({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeManager.getThemeMode(),
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.login,
      home: const MainLayoutScreen()
    );
  }
}