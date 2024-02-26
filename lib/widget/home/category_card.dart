import 'package:flutter/material.dart';

import '../cached_image.dart';

class CategoryCard extends StatelessWidget {
  String name;
  String numberOfCourses;
  String image;
  CategoryCard({super.key, required this.name,required this.image, required this.numberOfCourses});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  height: 110,
                  child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        child: CachedImage(
                          url: image,
                          fit: BoxFit.contain,
                        )
                    ),
                  )),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(name,
                        style: theme.textTheme.titleLarge),
                    Text("Number of courses $numberOfCourses",
                        style: theme.textTheme.bodySmall)
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}