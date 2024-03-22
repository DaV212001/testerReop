import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/config/config_preference.dart';
import 'package:mss_e_learning/util/app_routes.dart';
import 'package:mss_e_learning/widget/button.dart';

import '../../util/app_constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _currentPageAsDouble = 0;
  List<Map<String, dynamic>> pagesData = [
    {
      'title': 'Welcome to Learn JavaScript',
      'image': 'assets/images/illustrations/too_many_requests.svg',
      'description':
          'Begin your journey to master JavaScript with our interactive lessons and challenges.',
    },
    {
      'title': 'Practice Coding Skills',
      'image': 'assets/images/illustrations/too_many_requests.svg',
      'description':
          'Apply your knowledge and practice coding skills with real-world projects and exercises.',
    },
    {
      'title': 'Join a Community',
      'image': 'assets/images/illustrations/too_many_requests.svg',
      'description':
          'Connect with fellow learners, share insights, and collaborate on coding projects.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageAsDouble = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    final List<Widget> pages = [];
    for (var item in pagesData) {
      Widget page = Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Assuming you have imported the necessary packages
              SvgPicture.asset('${item['image']}', width: 200, height: 300),
              Text(
                item['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: theme.primaryText),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                item['description'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: theme.primaryText),
              ),
            ],
          ),
        ),
      );
      pages.add(page);
    }
    return Scaffold(
        backgroundColor: theme.primaryBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: _pageController,
                    children: pages,
                    onPageChanged: (page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                  ),
                ),
                if (pages.length > 1)
                  DotsIndicator(
                    dotsCount: pages.length,
                    position: _currentPage,
                    decorator: DotsDecorator(
                      activeColor: AppConstants.primary,
                      color: theme.primaryText.withOpacity(0.25),
                      activeSize: const Size(15, 15),
                      size: const Size(10, 10),
                    ),
                  ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 300,
                  child: Button(
                      text: "Next",
                      hasLoader: _currentPage == pages.length - 1,
                      onPress: _currentPage == pages.length - 1
                          ? onPressedOnLastPage
                          : _animateToNextPage),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _animateToNextPage() async {
    await _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  void onPressedOnLastPage() async {
    ConfigPreference.setFirstLaunchCompleted();
    Get.offAllNamed(AppRoutes.signup);
  }
}
