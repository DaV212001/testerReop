import 'package:get/get.dart';
import 'package:mss_e_learning/screen/main_layout_screen.dart';

import '../screen/auth/log_in.dart';
import '../screen/auth/sign_up.dart';
import '../screen/home/home_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const initial = '/main_screen';
  static const signup = '/signup';
  static const home = '/home';
  static const login = '/login';
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
        name: login,
        page: ()=> const LogInWidget()
    ),
    GetPage(
      name: signup,
      page: () => const SignUpWidget(),
    )
  ];
}