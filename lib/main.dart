import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/screen/home/home_screen.dart';
import 'package:mss_e_learning/screen/main_layout_screen.dart';
import 'package:mss_e_learning/service/authorization_service.dart';
import 'package:mss_e_learning/util/app_routes.dart';

import 'config/config_preference.dart';
import 'config/themes/data/app_themes.dart';
import 'config/themes/theme_manager.dart';
String? token;
Future<void> main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();
  FastCachedImageConfig.init();
  // init shared preference
  await ConfigPreference.init();

token = await AuthService.getAuthorizationToken();

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
      initialRoute: token == null? AppRoutes.signup : AppRoutes.initial,
      home: const MainLayoutScreen()
    );
  }
}