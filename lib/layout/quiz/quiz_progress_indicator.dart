import 'package:flutter/material.dart';

class QuizProgressIndicator extends StatelessWidget {
  final List<dynamic> items;
  final int progress;

  const QuizProgressIndicator(
      {super.key, required this.items, required this.progress});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        return Expanded(
          child: Container(
            height: 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: progress >= index
                  ? theme.colorScheme.primary
                  : theme.unselectedWidgetColor.withOpacity(0.2),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 4),
          ),
        );
      }).toList(),
    );
  }
}
