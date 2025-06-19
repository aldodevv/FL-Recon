import 'package:flutter/material.dart';

class Saldocard extends StatelessWidget {
  final String title;
  final String currencySymbol;
  final String value;
  final String dateTime;
  final bool isHidden;
  final VoidCallback onToggleVisibility;
  final VoidCallback onTapDetail;
  final String selectedCurrency;
  final Function(String?) onCurrencyChange;

  const Saldocard({
    super.key,
    required this.title,
    required this.currencySymbol,
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white, // Background putih
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4), // shadow ke bawah
          ),
        ],
      ),
      child: Column(
        children: [
          // Card biru di dalam container putih
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0052A4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris atas: judul + dropdown mata uang
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    _buildCurrencyDropdown(),
                  ],
                ),
                const SizedBox(height: 12),
                // Saldo + icon sembunyikan/tampilkan
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        isHidden ? '••••••••••••••' : value,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onToggleVisibility,
                      child: Icon(
                        isHidden ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Detail rekening
                GestureDetector(
                  onTap: onTapDetail,
                  child: Row(
                    children: const [
                      Text(
                        'Detail Rekening',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 6),
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
          ),
          const SizedBox(height: 8),
          // Bagian bawah: Multiple User dan tanggal, masih di dalam container putih
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Multiple User',
                    style: TextStyle(
                      color: Color(0xFF0052A4),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  dateTime,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCurrency,
          dropdownColor: Colors.white,
          iconEnabledColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (value) {
            if (value != null) {
              onCurrencyChange(value);
            }
          },
          items: [
            DropdownMenuItem(
              value: 'IDR',
              child: Row(
                children: const [
                  Icon(Icons.flag, color: Colors.red, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'IDR',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'USD',
              child: Row(
                children: const [
                  Icon(Icons.flag, color: Colors.blue, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'USD',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
