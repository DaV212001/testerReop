import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import '../cached_image.dart';

class SubCategoryCard extends StatelessWidget {
  String name;
  String image;
  SubCategoryCard({super.key, required this.name,required this.image});

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            color: theme.primary.withOpacity(0.25),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: theme.primary, width: 0.5)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 110,
                  child: Center(
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(2)),
                        child: CachedImage(
                          url: image,
                          fit: BoxFit.contain,
                        )
                    ),
                  )),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(fontSize: 17,
                            color: theme.primaryText
                        )),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
