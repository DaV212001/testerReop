import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/ad_controller.dart';
import 'package:mss_e_learning/screen/splash/splash_screen.dart';
import 'package:mss_e_learning/service/ads_service.dart';
import 'package:mss_e_learning/service/firebase_service.dart';
import 'package:mss_e_learning/util/ad_unit_ids.dart';
import 'package:mss_e_learning/util/app_routes.dart';
import 'package:mss_e_learning/util/firebase_options.dart';
import 'config/config_preference.dart';
import 'config/themes/data/app_themes.dart';
import 'config/themes/theme_manager.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();
  // init shared preference
  await ConfigPreference.init();
  // init image caching
  await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));
  // init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService().init();

  AdController adController = Get.put(AdController());
  adController.onInit();

  // init ads
  MobileAds.instance.initialize();

  runApp(const MssLearnProgramming());
}

class MssLearnProgramming extends StatelessWidget {
  const MssLearnProgramming({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: FlutterSmartDialog.init(),
        navigatorObservers: [FlutterSmartDialog.observer],
      navigatorKey: navigatorKey, // Assign the navigator key
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeManager.getThemeMode(),
        getPages: AppRoutes.pages,
        home: const SplashScreen(),
    );
  }
}

void restartApp() {
  navigatorKey.currentState?.pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const MssLearnProgramming()),
        (route) => false,
  );
}