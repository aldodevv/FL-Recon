import 'package:flutter/material.dart';

enum BadgeColorType { blue, orange, green, red }
enum BadgeSize { small, medium, large }

class StatusBadgeWidget extends StatelessWidget {
  final String? text;
  final Widget? child;
  final BadgeColorType colorType;
  final BadgeSize size;
  final bool showBorder;

  final double? fontSize;
  final EdgeInsets? padding;
  final double? borderRadius;

  const StatusBadgeWidget({
    super.key,
    this.text,
    this.child,
    this.colorType = BadgeColorType.blue,
    this.size = BadgeSize.medium,
    this.showBorder = false,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  Color _backgroundColor() {
    switch (colorType) {
      case BadgeColorType.orange:
        return const Color(0xFFFEEDDF);
      case BadgeColorType.green:
        return const Color(0xFFE1F8EB);
      case BadgeColorType.red:
        return const Color(0xFFFCE7E7);
      case BadgeColorType.blue:
      default:
        return const Color(0xFFDDEFFC);
    }
  }

  Color _textColor() {
    switch (colorType) {
      case BadgeColorType.orange:
        return const Color(0xFFF87304);
      case BadgeColorType.green:
        return const Color(0xFF27AE60);
      case BadgeColorType.red:
        return const Color(0xFFE84040);
      case BadgeColorType.blue:
      default:
        return const Color(0xFF1078CA);
    }
  }

  double _defaultFontSize() {
    switch (size) {
      case BadgeSize.small:
        return 12;
      case BadgeSize.large:
        return 18;
      case BadgeSize.medium:
      default:
        return 14;
    }
  }

  EdgeInsets _defaultPadding() {
    switch (size) {
      case BadgeSize.small:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
      case BadgeSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case BadgeSize.medium:
      default:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    }
  }

  double _defaultBorderRadius() {
    switch (size) {
      case BadgeSize.small:
        return 6;
      case BadgeSize.large:
        return 12;
      case BadgeSize.medium:
      default:
        return 8;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = child ??
        Text(
          text ?? '',
          style: TextStyle(
            fontSize: fontSize ?? _defaultFontSize(),
            color: _textColor(),
            fontWeight: FontWeight.bold,
          ),
        );

    return Container(
      padding: padding ?? _defaultPadding(),
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(borderRadius ?? _defaultBorderRadius()),
        border: showBorder ? Border.all(color: _textColor()) : null,
      ),
      child: content,
    );
  }
}
