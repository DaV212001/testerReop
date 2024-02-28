import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

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
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
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
              style: TextStyle(fontSize: 16,
                  color: theme.primaryText)
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
                          color: theme.primary),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      CupertinoIcons.arrow_right,
                      color: theme.primary,
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