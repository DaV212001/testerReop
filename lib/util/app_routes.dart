import 'package:get/get.dart';
import 'package:mss_e_learning/screen/certificate/certificate_screen.dart';
import 'package:mss_e_learning/screen/home/home_screen.dart';
import 'package:mss_e_learning/screen/main_layout_screen.dart';
import 'package:mss_e_learning/screen/onboarding/onboarding_screen.dart';
import 'package:mss_e_learning/screen/profile/profile_screen.dart';
import 'package:mss_e_learning/screen/quiz/quiz_end_screen.dart';
import 'package:mss_e_learning/screen/quiz/quiz_screen.dart';
import 'package:mss_e_learning/screen/splash/splash_screen.dart';

import '../screen/auth/log_in.dart';
import '../screen/auth/sign_up.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/splash_screen';
  static const initial = '/main_screen';
  static const signup = '/signup';
  static const home = '/home';
  static const login = '/login';
  static const onboarding = '/onboarding';
  static const profile = '/profile';
  static const category = '/category';
  static const certificate = '/certificate';
  static const quiz = '/quiz';
  static const quizEnd = '/quizEnd';

  static final pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: initial, page: () => const MainLayoutScreen()),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(name: quiz, page: () => const QuizScreen()),
    GetPage(name: quizEnd, page: () => const QuizEndScreen()),
    GetPage(name: certificate, page: () => const CertificateScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: login, page: () => const LogInWidget()),
    GetPage(
      name: signup,
      page: () => const SignUpWidget(),
    )
  ];
}
