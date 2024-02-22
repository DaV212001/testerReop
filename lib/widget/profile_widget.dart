import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mss_e_learning/config/themes/data/app_colors.dart';
import 'package:mss_e_learning/widget/cached_image.dart';

class ProfileWidget extends StatelessWidget {
  final dynamic imagePath;
  final VoidCallback onClicked;
  final bool isFile;
  final bool hasEditButton;

  const ProfileWidget(
      {super.key,
      required this.imagePath,
      required this.onClicked,
      required this.isFile,
      required this.hasEditButton});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              buildImage(theme.colorScheme.onSecondary.withOpacity(0.1)),
              if (hasEditButton && imagePath != null)
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: Ink(
                    child: InkWell(
                        onTap: onClicked,
                        child: buildEditIcon(theme.primaryColor)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImage(Color color) {
    return ClipOval(
      child: Material(
        color: color,
        child: Ink(
          width: 128,
          height: 128,
          child: InkWell(
              child: isFile
                  ? Image.file(
                      imagePath,
                      fit: BoxFit.cover,
                    )
                  : imagePath != null
                      ? CachedImage(
                          url: imagePath!,
                          fit: BoxFit.cover,
                        )
                      : IconButton(
                          onPressed: onClicked,
                          icon: const Icon(
                            color: AppColors.tropicalIndigo3,
                            CupertinoIcons.profile_circled,
                            size: 120,
                          ))),
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
