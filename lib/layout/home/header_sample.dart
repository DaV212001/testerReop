import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/themes/theme_manager.dart';

class HeaderSample extends StatelessWidget {
  const HeaderSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        //----------------Language Toggle----------------//
        InkWell(
          onTap: () => ThemeManager.changeTheme(),
          child: Ink(
            child: SizedBox(
              height: 39,
              width: 39,
              child: Icon(
                Get.isDarkMode
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

