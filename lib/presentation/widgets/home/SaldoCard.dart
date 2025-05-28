import 'package:flutter/material.dart';

class Saldocard extends StatelessWidget {
  final String title;
  final String currency;
  final String value;
  final String dateTime;
  final bool isHidden;
  final VoidCallback onToggleVisibility;
  final VoidCallback onTapDetail;
  final String selectedCurrency;
  final Function(String) onCurrencyChange;

  const Saldocard({
    super.key,
    required this.title,
    required this.currency,
    required this.value,
    required this.dateTime,
    required this.isHidden,
    required this.onToggleVisibility,
    required this.onTapDetail,
    required this.selectedCurrency,
    required this.onCurrencyChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0052A4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              GestureDetector(
                onTap: onToggleVisibility,
                child: const Icon(Icons.remove_red_eye, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                currency,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isHidden ? '••••••' : value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              _buildCurrencyToggle(),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                dateTime,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onTapDetail,
                child: Row(
                  children: const [
                    Text(
                      'Detail',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyToggle() {
    return Container(
      height: 30,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children:
            ['IDR', 'USD'].map((item) {
              final selected = selectedCurrency == item;
              return GestureDetector(
                onTap: () => onCurrencyChange(item),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: selected ? const Color(0xFF0052A4) : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
