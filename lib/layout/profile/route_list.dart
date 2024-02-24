import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mss_e_learning/config/themes/theme_manager.dart';

class RouteList extends StatelessWidget {
  const RouteList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Icon arrowIcon = Icon(Icons.arrow_right_outlined,
        color: theme.colorScheme.primary.withOpacity(0.8), size: 40);
    final List<Map<String, dynamic>> itemList = [
      {
        "title": "Change Profile",
        "leadingIcon": buildIcon(Icons.person_3_sharp, context),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "Change Password",
        "leadingIcon": buildIcon(Icons.password, context),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "Dark Mode",
        "leadingIcon": buildIcon(Icons.dark_mode_outlined, context),
        "onTap": () {},
        "trailing": Switch.adaptive(
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
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "FAQ",
        "leadingIcon": buildIcon(Icons.question_mark, context),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "Terms And Conditions",
        "leadingIcon": buildIcon(Icons.error, context),
        "onTap": () {},
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
              splashColor: theme.colorScheme.primary.withOpacity(0.3),
              highlightColor: theme.colorScheme.primary.withOpacity(0.25),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: theme.colorScheme.primary.withOpacity(0.15),
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
      color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
      size: 25,
    );
  }
}
