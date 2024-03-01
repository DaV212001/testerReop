import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mss_e_learning/model/error_data.dart';
import 'package:mss_e_learning/widget/button.dart';

class ErrorCard extends StatelessWidget {
  final ErrorData errorData;
  final VoidCallback? refresh;

  const ErrorCard({super.key, this.refresh, required this.errorData});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          errorData.image,
          width: 300,
          height: 300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(
            errorData.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Text(
            errorData.body,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: theme.unselectedWidgetColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        buildButton(errorData.buttonText)
      ],
    );
  }

  Widget buildButton(String? text) {
    if (text == null || refresh == null) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: 300,
      child: Button(
        text: text,
        onPress: refresh!,
      ),
    );
  }
}
