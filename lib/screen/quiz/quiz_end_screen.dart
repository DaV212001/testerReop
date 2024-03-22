import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:get/get.dart';
import 'package:mss_e_learning/controller/quiz_controller.dart';
import 'package:mss_e_learning/generated/assets.dart';
import 'package:mss_e_learning/widget/button.dart';

import '../../util/app_constants.dart';

class QuizEndScreen extends StatelessWidget {
  const QuizEndScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    final controller = Get.find<QuizController>();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: theme.primary));
    return Scaffold(
      backgroundColor: theme.primaryBackground,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close,
                  size: 35, color: theme.primaryText.withOpacity(0.5)),
            )
          ]),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: theme.primaryBackground,
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "Successfully Completed",
              style: theme.titleLarge
                  .copyWith(color: theme.primaryText.withOpacity(0.8)),
            ),
            const SizedBox(height: 10,),
            controller.practiceMode.value
                ? const SizedBox.shrink()
                : Text(
                    "${controller.noOfCorrectQuestions} / ${controller.questions.length}",
                    style: theme.displaySmall
                        .copyWith(color: AppConstants.primary.withOpacity(0.8)),
                  ),
            const SizedBox(height: 10,),
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
              child: Button(
                text: "Continue",
                onPress: () => {Get.toNamed(controller.quizEndRoute.value)},
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
