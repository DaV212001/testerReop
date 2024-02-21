import 'package:flutter/material.dart';
import 'package:mss_e_learning/config/themes/data/app_colors.dart';

class AppThemes {
  /* <----------------------->
      Light Theme
   <-----------------------> */
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: "Poppins",
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.tropicalIndigo3,
        primary: AppColors.tropicalIndigo3,
        onPrimary: AppColors.white,
        secondary: AppColors.tropicalIndigo3.withOpacity(0.5),
        onSecondary: AppColors.jet,
        background: AppColors.white,
        onBackground: AppColors.jet,
        error: AppColors.redCMYK,
        onError: AppColors.white,
      ),
      // buttonTheme: ButtonThemeData(
      //   buttonColor: AppColors.tropicalIndigo3,
      //   shape: RoundedRectangleBorder(
      //     borderRadius:
      //         BorderRadius.circular(10), // Set your desired border radius here
      //   ),
      // ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.linen,
          selectedItemColor: AppColors.tropicalIndigo3,
          unselectedItemColor: AppColors.jet.withOpacity(0.5)));

  /* <----------------------->
      Dark Themes For this app
   <-----------------------> */

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      fontFamily: "Poppins",
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.tropicalIndigo3,
        primary: AppColors.tropicalIndigo3,
        onPrimary: AppColors.white,
        secondary: AppColors.jet.withOpacity(0.5),
        onSecondary: AppColors.tropicalIndigo3,
        background: AppColors.darkPurple,
        onBackground: AppColors.white,
        error: AppColors.redCMYK,
        onError: AppColors.white,
      ),
      // buttonTheme: ButtonThemeData(
      //   buttonColor: AppColors.tropicalIndigo3,
      //   shape: RoundedRectangleBorder(
      //     borderRadius:
      //     BorderRadius.circular(10), // Set your desired border radius here
      //   ),
      // ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkPurple,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.white.withOpacity(0.4)));
}
