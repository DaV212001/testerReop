import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mss_e_learning/screen/profile/profile.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../config/themes/data/app_colors.dart';
import 'category/category_screen.dart';
import 'exam/exam_screen.dart';
import 'home/home_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  late PersistentTabController _controller;
  bool isLoggedIn = false;
  @override
  void initState() {
    _controller = PersistentTabController();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [
        const HomeScreen(), //Home Page
        const CategoryScreen(), //Category Page
        const ExamScreen(), //Cart Page
        const ProfileScreen()
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white70,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
      navBarHeight: 60,
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    Color activeColor = AppColors.PRIMARY_COLOR;
    Color inactiveColor = AppColors.ACCENT_COLOR;
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home, color: activeColor,),
          inactiveIcon: Icon(Icons.home, color: inactiveColor,),
          title: ('Home'),
          textStyle: TextStyle(fontSize: 10),
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          routeAndNavigatorSettings:
          const RouteAndNavigatorSettings(initialRoute: '/home')),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.list_alt, color: activeColor,),
          inactiveIcon: Icon(Icons.list_alt, color: inactiveColor,),
          title: ('Category'),
          textStyle: TextStyle(fontSize: 10),
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          routeAndNavigatorSettings:
          const RouteAndNavigatorSettings(initialRoute: '/category')),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.pending_actions, color: activeColor,),
          inactiveIcon: Icon(Icons.pending_actions, color: inactiveColor,),
          title: ('Exam'),
          textStyle: TextStyle(fontSize: 10),
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          routeAndNavigatorSettings:
          const RouteAndNavigatorSettings(initialRoute: '/exam')),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person, color: activeColor,),
          inactiveIcon: Icon(Icons.person, color: inactiveColor,),
          title: ('profile'.tr()),
          textStyle: TextStyle(fontSize: 10),
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          routeAndNavigatorSettings:
          const RouteAndNavigatorSettings(initialRoute: '/profile')),
    ];
  }
}
