import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import '../cached_image.dart';

class SubCategoryCard extends StatelessWidget {
  final String name;
  final String image;
  const SubCategoryCard({super.key, required this.name,required this.image});

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
          padding: const EdgeInsets.all(0.0),
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
                margin: const EdgeInsets.only(top: 5, left: 7),
                child: Text(name,
                    style: TextStyle(
                        color: theme.primaryText
                    )),
              ),
            ],
          ),
        )
    );
  }
}
