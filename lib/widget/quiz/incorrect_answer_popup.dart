import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:mss_e_learning/config/themes/data/app_colors.dart';

class IncorrectAnswerPopup extends StatelessWidget {
  final Function() next;
  final String answer;

  const IncorrectAnswerPopup(
      {super.key, required this.next, required this.answer});

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Container(
      height: 230,
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
              Icon(
                CupertinoIcons.multiply_circle_fill,
                color: AppColors.offRed,
                size: 30,
              ),
              const SizedBox(width: 10,),
              Text(
                "Incorrect",
                style: theme.headlineSmall.copyWith(
                    color: AppColors.offRed, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 15,),
          Text(
            "Correct Answer :",
            style: theme.titleMedium.copyWith(
                color: AppColors.offRed, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10,),
          //Todo handle overflow
          Text(answer,
              style: theme.bodyLarge.copyWith(color: AppColors.offRed)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.offRed,
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
