import 'package:flutter/material.dart';

class QuestionHeader extends StatelessWidget {
  final String question;

  const QuestionHeader({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Text(
          question,
          style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.8)),
        ),
        const SizedBox(height: 10),
        Text(
          "Select the correct answer",
          style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.8)),
        ),
      ],
    );
  }
}
