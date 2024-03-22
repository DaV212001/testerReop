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
      padding: EdgeInsets.symmetric(horizontal: 10),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 50,
            child: Text(
              title,
              maxLines: 2,
              softWrap: true,
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
                          color: Color(0xFFFF2C20)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      CupertinoIcons.arrow_right,
                      color: Color(0xFFFF2C20),
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