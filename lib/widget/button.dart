import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final bool awaitResponse;
  final bool enabled;
  final double? width;

  const Button(
      {super.key,
      required this.text,
      required this.onPress,
      this.enabled = true,
      this.awaitResponse = false,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled
              ? theme.buttonTheme.colorScheme?.primary
              : theme.buttonTheme.colorScheme?.primaryContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10), // Set your desired border radius here
          ),
        ),
        onPressed: awaitResponse
            ? null
            : enabled
                ? onPress
                : null,
        child: awaitResponse
            ? SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                    color: theme.buttonTheme.colorScheme?.onPrimary,
                    strokeWidth: 2.0))
            : Text(
                text,
                style: TextStyle(
                    color: theme.buttonTheme.colorScheme?.onPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
      ),
    );
  }
}
