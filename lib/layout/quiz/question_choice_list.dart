import 'package:flutter/material.dart';
import 'package:mss_e_learning/model/question.dart';

class QuestionChoiceList extends StatelessWidget {
  final Question question;

  const QuestionChoiceList({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
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
                onTap: () {},
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
}
