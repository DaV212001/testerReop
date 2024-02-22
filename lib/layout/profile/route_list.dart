import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mss_e_learning/model/user.dart';

class RouteList extends StatefulWidget {
  final User user;
  final Function() refresh;

  const RouteList({super.key, required this.user, required this.refresh});

  @override
  State<RouteList> createState() => _RouteListState();
}

class _RouteListState extends State<RouteList> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Icon arrowIcon = Icon(Icons.chevron_right_outlined,
        color: theme.colorScheme.primary, size: 25.sp);
    final List<Map<String, dynamic>> itemList = [
      {
        "title": "change_profile",
        "leadingIcon": Icons.account_circle_outlined,
        "onTap": () {},
        "trailing": arrowIcon,
        "special_icon": Icons.edit
      },
      {
        "title": "change_password",
        "leadingIcon": Icons.password,
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "privacy_policy",
        "leadingIcon": Icons.privacy_tip_outlined,
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "faq",
        "leadingIcon": Icons.question_mark,
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "terms_and_conditions",
        "leadingIcon": Icons.error,
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "about",
        "leadingIcon": Icons.info_outline_rounded,
        "onTap": () {},
        "trailing": arrowIcon
      }
    ];
    if (!Platform.isAndroid) {
      itemList.add({
        "title": "delete_account",
        "leadingIcon": Icons.delete_outline,
        "onTap": () {},
        "trailing": arrowIcon
      });
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
            color: theme.buttonTheme.colorScheme?.primaryContainer,
            borderRadius: BorderRadius.circular(10.r)),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            final item = itemList[index];
            final specialIcon = item["special_icon"];
            return SizedBox(
              height: 60.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      onTap: item["onTap"],
                      leading: specialIcon ??
                          Icon(
                            item["leadingIcon"],
                            color: theme.primaryColor,
                            size: 25,
                          ),
                      title: Text(item["title"],
                          style: const TextStyle(fontSize: 16)),
                      trailing: item["trailing"],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: index != itemList.length - 1
                        ? theme.dividerColor
                        : Colors.transparent,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
