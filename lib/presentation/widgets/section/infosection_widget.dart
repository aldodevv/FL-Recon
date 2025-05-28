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
      default:
        return MainGroupColors.blue;
    }
  }
}

class InfoSectionWidget extends StatelessWidget {
  final String text;
  final int? value;
  final IconData leftIcon;
  final IconData rightIcon;
  final double size;
  final bool reverse;
  final VoidCallback? onTap;
  final Widget? child;
  final ColorType colorType;

  const InfoSectionWidget({
    super.key,
    required this.text,
    this.value,
    this.leftIcon = Icons.info_outline,
    this.rightIcon = Icons.chevron_right,
    this.size = 16,
    this.reverse = false,
    this.onTap,
    this.child,
    this.colorType = ColorType.blue,
  });

  bool _isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  MainStatusColor _resolvedColor(BuildContext context) {
    final group = colorType.infoGroupColor;
    return _isDarkMode(context)
        ? MainStatusColor(background: group.color, color: group.background)
        : group;
  }

  Color _backgroundColor(BuildContext context) =>
      _resolvedColor(context).background;
  Color _borderColor(BuildContext context) =>
      _resolvedColor(context).color.withAlpha((255 * 0.5).round());
  Color _iconColor(BuildContext context) => _resolvedColor(context).color;
  Color _textColor(BuildContext context) => _resolvedColor(context).color;
  Color _valueColor(BuildContext context) => _resolvedColor(context).color;

  List<Widget> _buildContentChildren(BuildContext context) {
    final iconSize = size + 4;
    final fontSize = size;

    return [
      Icon(leftIcon, size: iconSize, color: _iconColor(context)),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, color: _textColor(context)),
        ),
      ),
      if (value != null)
        Text(
          '$value',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: _valueColor(context),
          ),
        ),
      const SizedBox(width: 4),
      Icon(rightIcon, size: iconSize, color: _iconColor(context)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: _backgroundColor(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _borderColor(context)),
        ),
        child:
            child ??
            Row(
              children:
                  reverse
                      ? _buildContentChildren(context).reversed.toList()
                      : _buildContentChildren(context),
            ),
      ),
    );
  }
}
