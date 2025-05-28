

import 'package:flutter/material.dart';
import 'package:recon/core/constants/colors_const.dart';
import 'package:recon/presentation/widgets/badge/infobadge_widget.dart';

class TransactionschedulecardWidget extends StatelessWidget {
  final String dateTime;
  final String statusText;
  final ColorType statusColorType;
  final String transactionId;
  final String description;
  final String amount;
  final String detailTitle;
  final VoidCallback onPressDetail;

  const TransactionschedulecardWidget({
    super.key,
    required this.dateTime,
    required this.statusText,
    required this.statusColorType,
    required this.transactionId,
    required this.description,
    required this.amount,
    required this.detailTitle,
    required this.onPressDetail,
  });

  bool _isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    final textColor = _isDarkMode(context) ? Colors.white : Colors.black;
    final secondaryColor = Colors.grey;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row: Date + Lihat Detail
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateTime,
                style: TextStyle(color: secondaryColor),
              ),
              GestureDetector(
                onTap: onPressDetail,
                child: Text(
                  detailTitle,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          /// Status Badge + Transaction ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusBadgeWidget(
                text: statusText,
                colorType: statusColorType,
                size: BadgeSize.small,
              ),
              Text(
                transactionId,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Description & Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                description,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                amount,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}