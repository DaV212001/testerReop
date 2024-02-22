import 'dart:io';

import 'package:flutter/material.dart';

class RouteList extends StatefulWidget {
  const RouteList({
    super.key,
  });

  @override
  State<RouteList> createState() => _RouteListState();
}

class _RouteListState extends State<RouteList> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Icon arrowIcon = Icon(Icons.chevron_right_outlined,
        color: theme.colorScheme.primary, size: 25);
    final List<Map<String, dynamic>> itemList = [
      {
        "title": "Change Profile",
        "leadingIcon": buildIcon(Icons.person_3_sharp),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "Change Password",
        "leadingIcon": buildIcon(Icons.password),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "Privacy Policy",
        "leadingIcon": buildIcon(Icons.privacy_tip_outlined),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "FAQ",
        "leadingIcon": buildIcon(Icons.question_mark),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "Terms And Conditions",
        "leadingIcon": buildIcon(Icons.error),
        "onTap": () {},
        "trailing": arrowIcon
      },
      {
        "title": "About",
        "leadingIcon": buildIcon(Icons.info_outline_rounded),
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
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: item["onTap"],
          leading: item["leadingIcon"],
          title: Text(item["title"], style: const TextStyle(fontSize: 16)),
          trailing: item["trailing"],
        );
      },
    );
  }

  Widget buildIcon(IconData iconData) {
    return Icon(
      iconData,
      color: Theme.of(context).colorScheme.primary,
      size: 25,
    );
  }
}
