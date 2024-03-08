import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import '../cached_image.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final String numberOfCourses;
  final String image;
  const CategoryCard({super.key, required this.name,required this.image, required this.numberOfCourses});

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width*0.3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: CachedImage(
                        url: image,
                        fit: BoxFit.fill,
                      )
                  )),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(fontSize: 16,
                        color: theme.primaryText
                        )),
                    Text("${int.parse(numberOfCourses) >1?"$numberOfCourses courses":"$numberOfCourses course"} ",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: theme.secondaryText))
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}