import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseHeader extends StatelessWidget {
  final String title;
  final bool showMore;
  final Function()? onTap;
  final String? showMoreText;

  const CourseHeader(
      {super.key,
        required this.title,
        this.showMore = false,
        this.onTap,
        this.showMoreText});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Text(
              title,
              style: theme.textTheme.titleLarge
            ),
          ),
          Visibility(
              visible: showMore,
              child: GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    Text(
                      showMoreText ?? "",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.primary),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      CupertinoIcons.arrow_right,
                      color: theme.colorScheme.primary,
                      size: 20,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}