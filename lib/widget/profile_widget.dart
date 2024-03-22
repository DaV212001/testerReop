import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mss_e_learning/widget/cached_image.dart';

import '../util/app_constants.dart';

class ProfileWidget extends StatelessWidget {
  final dynamic imagePath;
  final VoidCallback onClicked;
  final bool isFile;
  final bool hasEditButton;

  const ProfileWidget(
      {
      required this.imagePath,
      required this.onClicked,
      required this.isFile,
      required this.hasEditButton});

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Column(

      children: [
        Center(
          child: Stack(
            children: [
              buildImage(context),
              if (hasEditButton && imagePath != null )
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: Ink(
                    child: InkWell(
                        onTap: onClicked,
                        child: buildEditIcon(theme.primaryText)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImage(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return ClipOval(
      child: Material(
        child: Ink(
          child: InkWell(
              child: isFile
                  ? Image.file(
                      imagePath,
                      fit: BoxFit.cover,
                    )
                  : imagePath != null
                      ? Container(
                        width: MediaQuery.of(context).size.width/5,
                        height: MediaQuery.of(context).size.width/5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/5),
                          child: CachedImage(
                              url: imagePath!,
                              fit: BoxFit.cover,
                            ),
                        ),
                      )
                      : Center(
                        child: IconButton(
                            onPressed: onClicked,
                            icon: Icon(
                              color: AppConstants.primary,
                              CupertinoIcons.profile_circled,
                              size: MediaQuery.of(context).size.width / 6,
                            )),
                      )),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
