

import 'package:flutter/material.dart';
import 'package:recon/core/constants/colors_const.dart';
import 'package:recon/presentation/widgets/badge/infobadge_widget.dart';

class SaldoBadgeCardWidget extends StatelessWidget {
  final String title;
  final String amount;
  final List<BadgeData> badges;
  final Color leftColor;
  final BadgeSize size;
  final VoidCallback? onTap;

  const SaldoBadgeCardWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.badges,
    this.leftColor = const Color(0xFFEA580C),
    this.size = BadgeSize.medium,
    this.onTap,
  });

  bool _isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  double _getFontSize(double baseSize) {
    switch (size) {
      case BadgeSize.small:
        return baseSize * 0.8;
      case BadgeSize.large:
        return baseSize * 1.2;
      case BadgeSize.medium:
      default:
        return baseSize;
    }
  }

  double _getCardPadding() {
    switch (size) {
      case BadgeSize.small:
        return 12;
      case BadgeSize.large:
        return 20;
      case BadgeSize.medium:
      default:
        return 16;
    }
  }

  double _getLeftBarWidth() {
    switch (size) {
      case BadgeSize.small:
        return 4;
      case BadgeSize.large:
        return 8;
      case BadgeSize.medium:
      default:
        return 6;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _isDarkMode(context);
    final cardPadding = _getCardPadding();
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1F2937) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Left color bar
              Container(
                width: _getLeftBarWidth(),
                decoration: BoxDecoration(
                  color: leftColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with title and badges
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: _getFontSize(18),
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : const Color(0xFF111827),
                            ),
                          ),
                          const Spacer(),
                          ...badges.map((badge) => Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: StatusBadgeWidget(
                              text: badge.text,
                              child: badge.child,
                              colorType: badge.colorType,
                              size: size,
                              showBorder: badge.showBorder,
                              fontSize: badge.fontSize,
                              padding: badge.padding,
                              borderRadius: badge.borderRadius,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(height: cardPadding * 0.5),
                      // Amount
                      Text(
                        amount,
                        style: TextStyle(
                          fontSize: _getFontSize(24),
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF111827),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BadgeData {
  final String? text;
  final Widget? child;
  final ColorType colorType;
  final bool showBorder;
  final double? fontSize;
  final EdgeInsets? padding;
  final double? borderRadius;

  const BadgeData({
    this.text,
    this.child,
    this.colorType = ColorType.blue,
    this.showBorder = false,
    this.fontSize,
    this.padding,
    this.borderRadius,
  });
}