import 'package:flutter/material.dart';
import 'package:recon/core/constants/constant/colors_const.dart';

enum BadgeSize { small, medium, large }
extension ColorTypeExt on ColorType {
  MainStatusColor get groupColor {
    switch (this) {
      case ColorType.orange:
        return MainGroupColors.orange;
      case ColorType.green:
        return MainGroupColors.green;
      case ColorType.red:
        return MainGroupColors.red;
      case ColorType.blue:
      default:
        return MainGroupColors.blue;
    }
  }
}

class StatusBadgeWidget extends StatelessWidget {
  final String? text;
  final Widget? child;
  final ColorType colorType;
  final BadgeSize size;
  final bool showBorder;

  final double? fontSize;
  final EdgeInsets? padding;
  final double? borderRadius;

  const StatusBadgeWidget({
    super.key,
    this.text,
    this.child,
    this.colorType = ColorType.blue,
    this.size = BadgeSize.medium,
    this.showBorder = false,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });

  bool _isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  MainStatusColor _resolvedColor(BuildContext context) {
    final group = colorType.groupColor;
    return _isDarkMode(context)
        ? MainStatusColor(background: group.color, color: group.background)
        : group;
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
    final colorGroup = _resolvedColor(context);

    final content = child ??
        Text(
          text ?? '',
          style: TextStyle(
            fontSize: fontSize ?? _defaultFontSize(),
            color: colorGroup.color,
            fontWeight: FontWeight.bold,
          ),
        );

    return Container(
      padding: padding ?? _defaultPadding(),
      decoration: BoxDecoration(
        color: colorGroup.background,
        borderRadius:
            BorderRadius.circular(borderRadius ?? _defaultBorderRadius()),
        border: showBorder ? Border.all(color: colorGroup.color) : null,
      ),
      child: content,
    );
  }
}
