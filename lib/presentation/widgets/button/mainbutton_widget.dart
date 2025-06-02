import 'package:flutter/material.dart';
import 'package:recon/core/constants/colors_const.dart';

enum ButtonType { fullfilled, outlined, text }
enum ButtonSize { small, medium, large }

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

class MainbuttonWidget extends StatelessWidget {
  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final bool reverse;
  final MainAxisAlignment justify;
  final ColorType colorType;
  final ButtonSize size;
  final ButtonType type;

  const MainbuttonWidget({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.reverse = false,
    this.justify = MainAxisAlignment.center,
    this.colorType = ColorType.blue,
    this.size = ButtonSize.medium,
    this.type = ButtonType.fullfilled,
  });

  bool _isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  MainStatusColor _resolvedColor(BuildContext context) {
    final group = colorType.groupColor;
    return _isDarkMode(context)
        ? MainStatusColor(background: group.color, color: group.background)
        : group;
  }

  double _fontSize() {
    switch (size) {
      case ButtonSize.small:
        return 12;
      case ButtonSize.large:
        return 18;
      case ButtonSize.medium:
      default:
        return 14;
    }
  }

  EdgeInsets _padding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
      case ButtonSize.medium:
      default:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
    }
  }

  double _borderRadius() {
    switch (size) {
      case ButtonSize.small:
        return 6;
      case ButtonSize.large:
        return 12;
      case ButtonSize.medium:
      default:
        return 8;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = _resolvedColor(context);
    final bgColor = type == ButtonType.fullfilled ? colors.background : Colors.transparent;
    final textColor = type == ButtonType.fullfilled
        ? colors.color
        : type == ButtonType.outlined
            ? colors.background
            : colors.background;

    final border = type == ButtonType.outlined
        ? Border.all(color: colors.background)
        : null;

    final children = <Widget>[
      if (icon != null) icon!,
      if (icon != null) const SizedBox(width: 6),
      Text(
        text,
        style: TextStyle(
          fontSize: _fontSize(),
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: _padding(),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(_borderRadius()),
          border: border,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: justify,
          children: reverse ? children.reversed.toList() : children,
        ),
      ),
    );
  }
}
