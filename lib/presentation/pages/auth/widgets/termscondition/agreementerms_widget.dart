import 'package:flutter/material.dart';

class AgreementermsWidget extends StatelessWidget {
  final bool disableCheckbox;
  final bool checked;
  final VoidCallback? onCheck;
  final VoidCallback? onLogin;
  final bool loading;
  final bool disableButton;

  const AgreementermsWidget({
    super.key,
    this.disableCheckbox = false,
    this.checked = false,
    this.onCheck,
    this.onLogin,
    this.loading = false,
    this.disableButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Checkbox(
                value: checked,
                onChanged: disableCheckbox ? null : (_) => onCheck?.call(),
                activeColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Expanded(
                child: Text(
                  'Saya menyetujui syarat dan ketentuan yang berlaku', // Ganti dengan getLanguageById jika pakai localization
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: checked ? FontWeight.bold : FontWeight.w500,
                    height: 1.3,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (disableButton || loading) ? null : onLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // warna tombol
              ),
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Lanjut'),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
