import 'package:flutter/material.dart';

class CustomSixDigitVerificationCodeInput extends StatefulWidget {
  final ValueChanged<String> onCodeChanged;
  Color? color = Colors.grey;

  CustomSixDigitVerificationCodeInput({
    required this.onCodeChanged,
    required this.color,
  });

  @override
  _CustomSixDigitVerificationCodeInputState createState() =>
      _CustomSixDigitVerificationCodeInputState();
}

class _CustomSixDigitVerificationCodeInputState
    extends State<CustomSixDigitVerificationCodeInput> {
  late List<TextEditingController> digitControllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    digitControllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < 6; i++) {
      digitControllers[i].addListener(() {
        // Update the concatenated code whenever any digit changes
        widget.onCodeChanged(getVerificationCode());
        if (i < 5 && digitControllers[i].text.isNotEmpty) {
          // Move focus to the next field
          FocusScope.of(context).requestFocus(focusNodes[i + 1]);
        }
      });
    }
  }

  String getVerificationCode() {
    return digitControllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    digitControllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(6, (index) {
        final borderColor = widget.color;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              controller: digitControllers[index],
              focusNode: focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              textInputAction: index < 5 ? TextInputAction.next : TextInputAction.done,
              decoration: InputDecoration(
                counterText: '',
                hintText: "*",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor!, width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor, width: 3.0),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
