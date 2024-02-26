import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CorrectAnswerPopup extends StatelessWidget {
  final Function() next;
  const CorrectAnswerPopup({super.key, required this.next});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: 150,
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
                CupertinoIcons.check_mark_circled_solid,
                color: theme.colorScheme.tertiary,
                size: 30,
              ),
              const SizedBox(width: 10,),
              Text(
                "Correct",
                style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.tertiary, fontWeight: FontWeight.w700),
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
                backgroundColor: theme.buttonTheme.colorScheme?.tertiary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Set your desired border radius here
                ),
              ),
              child: Text(
                "Continue",
                style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.buttonTheme.colorScheme?.onTertiary),
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
