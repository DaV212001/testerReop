import 'package:get/get.dart';
import 'package:mss_e_learning/screen/main_layout_screen.dart';

import '../screen/home/home_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const initial = '/main_screen';
  static const home = '/home';

  static final pages = [
    GetPage(
      name: initial,
      page: () => const MainLayoutScreen()
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
  ];
}