import 'package:flutter/material.dart';
import 'package:mss_e_learning/config/themes/data/app_colors.dart';

class AppThemes {
  /* <----------------------->
      Light Theme
   <-----------------------> */
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.tropicalIndigo,
        primary: AppColors.tropicalIndigo,
        onPrimary: AppColors.white,
        secondary: AppColors.tropicalIndigo.withOpacity(0.5),
        onSecondary: AppColors.jet,
        background: AppColors.linen,
        onBackground: AppColors.jet,
        error: AppColors.redCMYK,
        onError: AppColors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.linen,
        selectedItemColor: AppColors.tropicalIndigo,
        unselectedItemColor: AppColors.jet.withOpacity(0.5)
      )
  );

  /* <----------------------->
      Dark Themes For this app
   <-----------------------> */

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.tropicalIndigo,
        primary: AppColors.tropicalIndigo,
        onPrimary: AppColors.white,
        secondary: AppColors.jet.withOpacity(0.5),
        onSecondary: AppColors.tropicalIndigo,
        background: AppColors.darkPurple,
        onBackground: AppColors.white,
        error: AppColors.redCMYK,
        onError: AppColors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkPurple,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.white.withOpacity(0.4)
      )
  );
}
