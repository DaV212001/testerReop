import 'package:flutter/material.dart';

class CustomSixDigitVerificationCodeInput extends StatefulWidget {
  final String? initialCode;
  final ValueChanged<String> onCodeChanged;
  final bool isValid; // New property for validation

  CustomSixDigitVerificationCodeInput({
    this.initialCode,
    required this.onCodeChanged,
    required this.isValid, // Pass the boolean value
  });

  @override
  _CustomSixDigitVerificationCodeInputState createState() =>
      _CustomSixDigitVerificationCodeInputState();
}

class _CustomSixDigitVerificationCodeInputState
    extends State<CustomSixDigitVerificationCodeInput> {
  late List<TextEditingController> digitControllers;

  @override
  void initState() {
    super.initState();
    digitControllers = List.generate(6, (_) => TextEditingController());
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < 6; i++) {
      digitControllers[i].text = widget.initialCode?[i]??'*';
      digitControllers[i].addListener(() {
        // Update the concatenated code whenever any digit changes
        widget.onCodeChanged(getVerificationCode());
      });
    }
  }

  String getVerificationCode() {
    return digitControllers.map((controller) => controller.text).join();
  }

  @override
  void dispose() {
    digitControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(6, (index) {

        final borderColor = Colors.grey;// Invalid state: red border

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextField(
              controller: digitControllers[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 1,
              decoration: InputDecoration(
                counterText: '',
                hintText: "*",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor, width: 3.0),
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
