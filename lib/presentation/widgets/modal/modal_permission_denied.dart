import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ModalPermissionDenied extends StatelessWidget {
  final List<Permission> denied;

  const ModalPermissionDenied({super.key, required this.denied});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.4),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Izin Diperlukan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Izin berikut ditolak:\n${denied.map((e) => e.toString().split('.').last).join(', ')}\n\n"
                  "Buka pengaturan untuk mengizinkan.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await openAppSettings();
                  },
                  child: const Text("Buka Pengaturan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
