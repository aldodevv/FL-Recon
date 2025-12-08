import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final FocusNode focus;
  final String labelName;
  final TextInputType? textInputType;

  const TextInput({
    super.key,
    required this.focus,
    required this.labelName,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focus,
      decoration: InputDecoration(labelText: labelName),
      keyboardType: textInputType,
    );
  }
}
