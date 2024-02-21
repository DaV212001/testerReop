import 'package:get/get.dart';
import 'package:mss_e_learning/screen/home/home_screen.dart';
import 'package:mss_e_learning/screen/main_layout_screen.dart';
import 'package:mss_e_learning/screen/onboarding/onboarding_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const initial = '/main_screen';
  static const home = '/home';
  static const onboarding = '/onboarding';

  static final pages = [
    GetPage(
      name: initial,
      page: () => const MainLayoutScreen()
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
        name: onboarding,
        page: () => const OnboardingScreen()
    ),
  ];
}