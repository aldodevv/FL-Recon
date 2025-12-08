import 'package:flutter/material.dart';

class ButtonCurrencyWidget extends StatelessWidget {
  final String value;
  final void Function()? onChangeFlag;

  const ButtonCurrencyWidget({
    super.key,
    required this.value,
    required this.onChangeFlag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChangeFlag,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(20),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_downward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
