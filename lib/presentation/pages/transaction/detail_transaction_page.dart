import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DetailTransactionPage extends StatelessWidget {
  const DetailTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
             
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Qlola',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              
              // Success Title
              const Text(
                'Transaksi Sukses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Date
              const Text(
                '12 Januari 2023, 10:45 WIB',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Konversi Valas Title
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Konversi Valas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Transaction Details Card
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Source Account
                        _buildAccountCard(
                          title: 'Rekening Sumber',
                          name: 'CLARA BONITA',
                          account: '(IDR) 020601004596562',
                          flag: '🇮🇩',
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Destination Account
                        _buildAccountCard(
                          title: 'Rekening Tujuan',
                          name: 'IBRAHIM WIJAYA',
                          account: '(CNY) 343723859375869',
                          flag: '🇨🇳',
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Transaction Details
                        _buildDetailRow('Tanggal Transaksi', '18/11/2023 17:09:18'),
                        _buildDetailRow('ID Transaksi', '2001000001618858'),
                        _buildDetailRow('Info Kurs', 'CNY 1,00 = IDR\n2.184,53', hasIcon: true),
                        _buildDetailRow('Catatan', 'DP tas longchamp'),
                        _buildDetailRow('Waktu Transfer', 'Sekarang'),
                        
                         Divider(height: 30, thickness: 1, color: Colors.grey[300]),
                        
                        _buildDetailRow('Nominal Transfer', 'IDR 87.500,00', isBold: true),
                        _buildDetailRow('Nominal Diterima', 'CNY 40,05', isBold: true),
                        
                         Divider(height: 30, thickness: 2, color: Colors.grey[400]),
                        
                        _buildDetailRow('Total Nominal', 'IDR 87.500,00', 
                            isBold: true, isTotal: true),
                        
                        const SizedBox(height: 30),
                        
                        // Footer
                        const Text(
                          '© 2025 PT Bank Rakyat Indonesia (Persero) Tbk.\nTerdaftar dan diawasi oleh Otoritas Jasa Keuangan.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccountCard({
    required String title,
    required String name,
    required String account,
    required String flag,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      account,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                flag,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 8),
              const Text(
                'BRI',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, 
      {bool isBold = false, bool isTotal = false, bool hasIcon = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: isTotal ? 18 : 14,
                      fontWeight: isBold || isTotal ? FontWeight.bold : FontWeight.normal,
                      color: isTotal ? Colors.black : Colors.black87,
                    ),
                  ),
                ),
                if (hasIcon) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Colors.blue,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}