import 'package:flutter/material.dart';

class InfoSectionWidget extends StatelessWidget {
  final String text;
  final int? value;
  final IconData leftIcon;
  final IconData rightIcon;
  final double size;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final Color valueColor;
  final bool reverse;
  final VoidCallback? onTap;
  final Widget? child;

  const InfoSectionWidget({
    super.key,
    required this.text,
    this.value,
    this.leftIcon = Icons.info_outline,
    this.rightIcon = Icons.chevron_right,
    this.size = 16,
    this.backgroundColor = const Color(0xFFE6F2FF),
    this.borderColor = const Color(0xFF2196F3),
    this.iconColor = const Color(0xFF2196F3),
    this.textColor = Colors.grey,
    this.valueColor = const Color(0xFF0D47A1),
    this.reverse = false,
    this.onTap,
    this.child,
  });

  List<Widget> _buildContentChildren() {
    final iconSize = size + 4;
    final fontSize = size;

    return [
      Icon(leftIcon, size: iconSize, color: iconColor),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: textColor),
        ),
      ),
      if (value != null)
        Text(
          '$value',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: valueColor,
          ),
        ),
      const SizedBox(width: 4),
      Icon(rightIcon, size: iconSize, color: iconColor),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: child ??
            Row(
              children: reverse
                  ? _buildContentChildren().reversed.toList()
                  : _buildContentChildren(),
            ),
      ),
    );
  }
}
