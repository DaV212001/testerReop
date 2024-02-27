import 'package:get/get.dart';
import 'package:mss_e_learning/screen/main_layout_screen.dart';
import 'package:mss_e_learning/screen/password/forgot_password_screen.dart';
import 'package:mss_e_learning/screen/onboarding/onboarding_screen.dart';
import 'package:mss_e_learning/screen/profile/profile_screen.dart';

import '../screen/auth/log_in.dart';
import '../screen/auth/sign_up.dart';
import '../screen/certificate/certificate_screen.dart';
import '../screen/exam/exam_screen.dart';
import '../screen/home/home_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const initial = '/main_screen';
  static const signup = '/signup';
  static const home = '/home';
  static const login = '/login';
  static const forgotpass = '/forgotpassword';
  static const onboarding = '/onboarding';
  static const profile = '/profile';
  static const category = '/category';
  static const certificate = '/certificate';
  static const exam = '/exam';
  static const changepass = '/changepass';

  static final pages = [
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: initial, page: () => const MainLayoutScreen()),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(name: exam, page: () => const ExamScreen()),
    GetPage(name: certificate, page: () => const CertificateScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: login, page: () => const LogInWidget()),
    GetPage(
      name: signup,
      page: () => const SignUpWidget(),
    ),
    GetPage(
        name: forgotpass,
        page: () => ForgotPasswordScreen()
    )
  ];
}