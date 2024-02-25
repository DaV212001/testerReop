import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:mss_e_learning/model/question.dart';
import 'package:get/get.dart';

class QuestionChoiceList extends StatelessWidget {
  final Question question;

  const QuestionChoiceList({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Expanded(
      child: ListView.builder(
          itemCount: question.answers.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: 2 == index
                      ? theme.colorScheme.primary.withOpacity(0.9)
                      : theme.colorScheme.onBackground.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(10),
                color: 2 == index
                    ? theme.colorScheme.primary.withOpacity(0.9)
                    : Colors.transparent,
              ),
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  _show();
                },
                splashColor: theme.colorScheme.primary.withOpacity(0.3),
                highlightColor: theme.colorScheme.primary.withOpacity(0.25),
                child: ListTile(
                  title: Text(
                    question.answers[index].answer,
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: 2 == index ? theme.colorScheme.onPrimary : null),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _show() async {
    SmartDialog.show(
        alignment: Alignment.bottomCenter,
        backDismiss: false,
        clickMaskDismiss: false,
        builder: (_) {
          return Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.background,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))
            ),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () => SmartDialog.dismiss(),
              child: const Text('再会！'),
            ),
          );
        });
  }
}
