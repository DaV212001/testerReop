import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class IncorrectAnswerPopup extends StatelessWidget {
  final Function() next;
  final String answer;

  const IncorrectAnswerPopup(
      {super.key, required this.next, required this.answer});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 230,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: theme.colorScheme.background,
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
                color: theme.colorScheme.error,
                size: 30,
              ),
              const SizedBox(width: 10,),
              Text(
                "Incorrect",
                style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.error, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 15,),
          Text(
            "Correct Answer :",
            style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10,),
          //Todo handle overflow
          Text(answer,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.error)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.buttonTheme.colorScheme?.error,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Set your desired border radius here
                ),
              ),
              child: Text(
                "Continue",
                style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.buttonTheme.colorScheme?.onError),
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
