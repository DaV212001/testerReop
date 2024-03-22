import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mss_e_learning/config/themes/theme_manager.dart';
import 'package:mss_e_learning/screen/bookmarks/bookmark_screen.dart';
import 'package:mss_e_learning/screen/password/change_password_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mss_e_learning/screen/app_documentation/privacy_policy_screen.dart';
import '../../screen/app_documentation/faq_screen.dart';
import '../../screen/app_documentation/terms_and_conditions_screen.dart';
import '../../screen/profile/change_profile_screen.dart';
import '../../util/app_constants.dart';

class RouteList extends StatelessWidget {
  const RouteList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    Icon arrowIcon = Icon(Icons.arrow_right_outlined,
        color: AppConstants.primary.withOpacity(0.8), size: 40);
    final List<Map<String, dynamic>> itemList = [
      {
        "title": "Change Profile",
        "leadingIcon": buildIcon(Icons.person_3_sharp, context),
        "onTap": () {
          Get.to( () => const ChangeProfileScreen());
        },
        "trailing": arrowIcon
      },
      {
        "title": "Change Password",
        "leadingIcon": buildIcon(Icons.password, context),
        "onTap": () {
          Get.to( ()=> const ChangePasswordScreen());
        },
        "trailing": arrowIcon
      },
      {
        "title": "Bookmarks",
        "leadingIcon": buildIcon(FontAwesomeIcons.bookmark, context),
        "onTap": () {
          Get.to( () => const BookMarkScreen());
        },
        "trailing": arrowIcon
      },
      {
        "title": "Dark Mode",
        "leadingIcon": buildIcon(Icons.dark_mode_outlined, context),
        "onTap": () {},
        "trailing": Switch.adaptive(
          activeColor: AppConstants.primary,
          thumbColor: MaterialStatePropertyAll<Color>(Colors.black),
          value: !ThemeManager.getThemeIsLight,
          onChanged: (bool value) {
            ThemeManager.changeTheme();
          },
        )
      },
      {
        "title": "Remove ADS",
        "leadingIcon": buildIcon(Icons.adb, context),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "Share This App",
        "leadingIcon": buildIcon(Icons.share, context),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "More Apps",
        "leadingIcon": buildIcon(Icons.android, context),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "Rate Us",
        "leadingIcon": buildIcon(Icons.star_rate_outlined, context),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "Privacy Policy",
        "leadingIcon": buildIcon(Icons.privacy_tip_outlined, context),
        "onTap": () {
          Get.to(()=> const PrivacyPolicyScreen());
        },
        "trailing": arrowIcon
      },
      {
        "title": "FAQ",
        "leadingIcon": buildIcon(Icons.question_mark, context),
        "onTap": () {
          Get.to(()=> FAQScreen());
        },
        "trailing": arrowIcon
      },
      {
        "title": "Terms And Conditions",
        "leadingIcon": buildIcon(Icons.error, context),
        "onTap": () {
          Get.to(()=>  TermAndConditionScreen());
        },
        "trailing": arrowIcon
      },
      {
        "title": "About",
        "leadingIcon": buildIcon(Icons.info_outline_rounded, context),
        "onTap": () {},
        "trailing": arrowIcon
      }
    ];
    if (!Platform.isAndroid) {
      itemList.add({
        "title": "delete_account",
        "leadingIcon": Icons.delete_outline,
        "onTap": () {},
        "trailing": arrowIcon,
      });
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final item = itemList[index];
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: item["onTap"],
              splashColor: AppConstants.primary.withOpacity(0.3),
              highlightColor: AppConstants.primary.withOpacity(0.25),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: AppConstants.primary.withOpacity(0.15),
                    width: 1
                  )
                ),
                tileColor: theme.primaryBackground,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                leading: item["leadingIcon"],
                title:
                    Text(item["title"], style: const TextStyle(fontSize: 16)),
                trailing: item["trailing"],
              ),
            ));
      },
    );
  }

  Widget buildIcon(IconData iconData, BuildContext context) {
    return Icon(
      iconData,
      color: AppConstants.primary.withOpacity(0.8),
      size: 25,
    );
  }
}
