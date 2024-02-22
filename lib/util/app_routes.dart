import 'package:get/get.dart';
import 'package:mss_e_learning/screen/certificate/certificate_screen.dart';
import 'package:mss_e_learning/screen/exam/exam_screen.dart';
import 'package:mss_e_learning/screen/home/home_screen.dart';
import 'package:mss_e_learning/screen/main_layout_screen.dart';
import 'package:mss_e_learning/screen/onboarding/onboarding_screen.dart';
import 'package:mss_e_learning/screen/profile/profile_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const initial = '/main_screen';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const profile = '/profile';
  static const category = '/category';
  static const certificate = '/certificate';
  static const exam = '/exam';

  static final pages = [
    GetPage(
        name: onboarding,
        page: () => const OnboardingScreen()
    ),
    GetPage(
      name: initial,
      page: () => const MainLayoutScreen()
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
        name: exam,
        page: () => const ExamScreen()
    ),
    GetPage(
        name: certificate,
        page: () => const CertificateScreen()
    ),
    GetPage(
        name: profile,
        page: () => const ProfileScreen()
    ),
  ];
}