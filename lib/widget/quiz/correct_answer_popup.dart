import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mss_e_learning/config/themes/data/app_colors.dart';

class CorrectAnswerPopup extends StatelessWidget {
  final Function() next;

  const CorrectAnswerPopup({super.key, required this.next});

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: theme.primaryBackground,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Row(
            children: [
              const Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: AppColors.limeGreen,
                size: 30,
              ),
              const SizedBox(width: 10,),
              Text(
                "Correct",
                style: theme.headlineSmall.copyWith(
                    color: AppColors.limeGreen,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.limeGreen,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Set your desired border radius here
                ),
              ),
              child: Text(
                "Continue",
                style: theme.bodyLarge.copyWith(
                    color: AppColors.white),
              ),
              onPressed: () => {next(), SmartDialog.dismiss()},
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
