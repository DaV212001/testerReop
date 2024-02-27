import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/quiz_controller.dart';
import 'package:mss_e_learning/generated/assets.dart';

class QuizEndScreen extends StatelessWidget {
  const QuizEndScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final controller = Get.find<QuizController>();
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close,
              size: 35, color: theme.colorScheme.onBackground.withOpacity(0.5)),
        )
      ]),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "Successfully Completed",
              style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.8)),
            ),
            const Spacer(),
            SvgPicture.asset(
              width: 300,
              height: 300,
              Assets.illustrationsWinnersPana,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.buttonTheme.colorScheme?.primary,
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
                onPressed: () => {Get.toNamed(controller.quizEndRoute.value)},
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
