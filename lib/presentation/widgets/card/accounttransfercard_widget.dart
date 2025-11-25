import 'package:flutter/material.dart';
import 'package:recon/core/constants/colors_const.dart';
import 'package:recon/presentation/widgets/badge/infobadge_widget.dart';

class AccounttransfercardWidget extends StatelessWidget {
  final String logoUrl;
  final String title;
  final String desc;
  final String badgeText;
  final ColorType badgeColor;
  final BadgeSize badgeSize;

  const AccounttransfercardWidget({
    super.key,
    required this.logoUrl,
    required this.title,
    required this.desc,
    required this.badgeText,
    this.badgeColor = ColorType.blue,
    this.badgeSize = BadgeSize.small,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                logoUrl,
                width: 40,
                height: 16,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 40,
                    height: 16,
                    color: Colors.grey.shade200, // placeholder background
                    child: const Icon(
                      Icons.broken_image,
                      size: 12,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
              const SizedBox(width: 30),
              StatusBadgeWidget(
                text: badgeText,
                colorType: badgeColor,
                size: badgeSize,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Title
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          // Description
          Text(
            desc,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
