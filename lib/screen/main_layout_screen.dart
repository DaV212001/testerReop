import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mss_e_learning/screen/certificate/certificate_screen.dart';
import 'package:mss_e_learning/screen/profile/profile_screen.dart';
import 'package:mss_e_learning/screen/quiz/quiz_screen.dart';
import 'package:mss_e_learning/util/app_routes.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../util/app_constants.dart';
import 'category/category_screen.dart';
import 'home/home_screen.dart';
import 'package:mss_e_learning/controller/user_controller.dart';

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
    UserController controller = Get.put(UserController(), tag: 'User');

    List<Widget> buildScreens() {
      return [
        const HomeScreen(), //Home Page
        // const CategoryScreen(), //Category Page
         CertificatesListScreen(), //Cart Page
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
        navBarStyle: NavBarStyle.style8,
        navBarHeight: 60,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    Color activeColor = AppConstants.primary;
    Color inactiveColor = theme.primaryText.withOpacity(0.5);
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
            FontAwesomeIcons.house,
            color: activeColor,
          ),
          inactiveIcon: Icon(
            FontAwesomeIcons.house,
            color: inactiveColor,
          ),
          title: ('TTTTTTT'),
          textStyle: const TextStyle(fontSize: 10),
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(initialRoute: AppRoutes.home)),
      // PersistentBottomNavBarItem(
      //     icon: Icon(
      //       FontAwesomeIcons.list,
      //       color: activeColor,
      //     ),
      //     inactiveIcon: Icon(
      //       FontAwesomeIcons.list,
      //       color: inactiveColor,
      //     ),
      //     title: ('Category'),
      //     textStyle: const TextStyle(fontSize: 10),
      //     activeColorPrimary: activeColor,
      //     inactiveColorPrimary: inactiveColor,
      //     routeAndNavigatorSettings: const RouteAndNavigatorSettings(
      //         initialRoute: AppRoutes.category)),
      PersistentBottomNavBarItem(
          icon: Icon(
            FontAwesomeIcons.certificate,
            color: activeColor,
          ),
          inactiveIcon: Icon(
            FontAwesomeIcons.certificate,
            color: inactiveColor,
          ),
          title: ('Certficates'),
          textStyle: const TextStyle(fontSize: 10),
          activeColorPrimary: activeColor,
          inactiveColorPrimary: inactiveColor,
          routeAndNavigatorSettings:
              const RouteAndNavigatorSettings(initialRoute: AppRoutes.certificate)),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.person_2_rounded,
            color: activeColor,
          ),
          inactiveIcon: Icon(
            Icons.person_2_rounded,
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
