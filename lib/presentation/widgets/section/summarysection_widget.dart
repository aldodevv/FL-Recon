import 'package:flutter/material.dart';
import 'package:recon/core/constants/colors_const.dart';

extension ColorTypeExt on ColorType {
  MainStatusColor get infoGroupColor {
    switch (this) {
      case ColorType.orange:
        return MainGroupColors.orange;
      case ColorType.green:
        return MainGroupColors.green;
      case ColorType.red:
        return MainGroupColors.red;
      case ColorType.blue:
        return MainGroupColors.blue;
    }
  }
}

enum SummarysectionType { harian, success, diproses, gagal }

extension SummarysectionTypeExt on SummarysectionType {
  ColorType get colorType {
    switch (this) {
      case SummarysectionType.success:
        return ColorType.green;
      case SummarysectionType.diproses:
        return ColorType.orange;
      case SummarysectionType.gagal:
        return ColorType.red;
      case SummarysectionType.harian:
        return ColorType.blue;
    }
  }

  IconData get defaultIcon {
    switch (this) {
      case SummarysectionType.success:
        return Icons.receipt_long;
      case SummarysectionType.diproses:
        return Icons.hourglass_bottom;
      case SummarysectionType.gagal:
        return Icons.receipt;
      case SummarysectionType.harian:
        return Icons.calendar_month;
    }
  }

  MainStatusColor get colorGroup => colorType.infoGroupColor;
}

class SummarysectionWidget extends StatelessWidget {
  final SummarysectionType type;
  final int value;
  final double iconSize;
  final double fontSize;
  final IconData? icon;
  final String label;

  const SummarysectionWidget({
    super.key,
    required this.type,
    required this.value,
    this.icon,
    this.iconSize = 32,
    this.fontSize = 16,
    this.label = '',
  });

  bool _isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    final theme = type;
    final colorGroup = theme.colorGroup;

    final bgColor =
        _isDarkMode(context)
            ? colorGroup.color.withAlpha((0.15 * 255).toInt())
            : colorGroup.background.withAlpha((0.6 * 255).toInt());
    final contentColor = colorGroup.color;

    return Column(
      children: [
        Container(
          width: 70,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                icon ?? theme.defaultIcon,
                size: iconSize,
                color: contentColor,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: contentColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 70,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: contentColor,
            ),
          ),
        ),
      ],
    );
  }
}

// === Optional: Demo Widget ===
class SummarysectionWidgetDemo extends StatelessWidget {
  const SummarysectionWidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result Info Cards')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SummarysectionWidget(
              type: SummarysectionType.harian,
              value: 70,
              icon: Icons.date_range, // custom icon
            ),
            SummarysectionWidget(type: SummarysectionType.success, value: 80),
            SummarysectionWidget(type: SummarysectionType.diproses, value: 10),
            SummarysectionWidget(type: SummarysectionType.gagal, value: 5),
          ],
        ),
      ),
    );
  }
}
