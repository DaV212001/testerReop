import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:mss_e_learning/config/config_preference.dart';
import 'package:mss_e_learning/generated/assets.dart';
import 'package:mss_e_learning/screen/auth/sign_up.dart';
import 'package:mss_e_learning/screen/main_layout_screen.dart';
import 'package:mss_e_learning/screen/onboarding/onboarding_screen.dart';
import 'package:mss_e_learning/service/authorization_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Widget> futureCall() async {
    bool isFirstLaunch = ConfigPreference.isFirstLaunch();
    String? token = await AuthService.getAuthorizationToken();
    //this way the image loads for sum reason(instead of using durationInSeconds)
    await Future.delayed(const Duration(seconds: 3));
    return isFirstLaunch
        ? Future.value(const OnboardingScreen())
        : token != null
            ? Future.value(const MainLayoutScreen())
            : Future.value(const SignUpWidget());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return EasySplashScreen(
      logo: Image.asset(Assets.imagesPlaceholderLogo),
      logoWidth: 200,
      title: null,
      backgroundColor: theme.colorScheme.background,
      showLoader: false,
      loadingText: Text("Loading...", style: theme.textTheme.bodyLarge),
      futureNavigator: futureCall(),
      durationInSeconds: 0,
    );
  }
}
