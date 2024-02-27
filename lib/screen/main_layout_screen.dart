import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mss_e_learning/screen/profile/profile_screen.dart';
import 'package:mss_e_learning/screen/quiz/quiz_screen.dart';
import 'package:mss_e_learning/util/app_routes.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'category/category_screen.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    List<Widget> buildScreens() {
      return [
        const HomeScreen(), //Home Page
        const CategoryScreen(), //Category Page
        const QuizScreen(), //Cart Page
        const ProfileScreen()
      ];

    }

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: theme.primaryBackground,
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
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    Color activeColor = theme.primary;
    Color inactiveColor = theme.primaryText.withOpacity(0.5);
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home,
            color: activeColor,
          ),
          inactiveIcon: Icon(
            Icons.home,
            color: inactiveColor,
          ),
          title: ('Home'),
          textStyle: const TextStyle(fontSize: 10),
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(initialRoute: AppRoutes.home)),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.list_alt,
            color: activeColor,
          ),
          inactiveIcon: Icon(
            Icons.list_alt,
            color: inactiveColor,
          ),
          title: ('Category'),
          textStyle: const TextStyle(fontSize: 10),
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          routeAndNavigatorSettings: const RouteAndNavigatorSettings(
              initialRoute: AppRoutes.category)),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.pending_actions,
            color: activeColor,
          ),
          inactiveIcon: Icon(
            Icons.pending_actions,
            color: inactiveColor,
          ),
          title: ('Quiz'),
          textStyle: const TextStyle(fontSize: 10),
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(initialRoute: AppRoutes.quiz)),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.person,
            color: activeColor,
          ),
          inactiveIcon: Icon(
            Icons.person,
            color: inactiveColor,
          ),
          title: ('Profile'),
          textStyle: const TextStyle(fontSize: 10),
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(initialRoute: AppRoutes.profile)),
    ];
  }
}
