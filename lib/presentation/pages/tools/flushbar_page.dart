import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FlushbarPage extends StatelessWidget {
  const FlushbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Flushbar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () => _showTopFlushbar(context),
            child: const Text('Flushbar di Atas'),
          ),
          ElevatedButton(
            onPressed: () => _showBottomFlushbar(context),
            child: const Text('Flushbar di Bawah'),
          ),
          ElevatedButton(
            onPressed: () => _showWithInput(context),
            child: const Text('Flushbar dengan Input'),
          ),
          ElevatedButton(
            onPressed: () => _showGradientFlushbar(context),
            child: const Text('Flushbar dengan Gradient & Icon'),
          ),
          ElevatedButton(
            onPressed: () => _showProgressFlushbar(context),
            child: const Text('Flushbar dengan Progress'),
          ),
          ElevatedButton(
            onPressed: () => _showDismissFlushbar(context),
            child: const Text('Flushbar Dismissable'),
          ),
        ],
      ),
    );
  }

  void _showTopFlushbar(BuildContext context) {
    Flushbar(
      title: 'Top Alert',
      message: 'Flushbar muncul dari atas',
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  void _showBottomFlushbar(BuildContext context) {
    Flushbar(
      title: 'Bottom Alert',
      message: 'Flushbar muncul dari bawah',
      flushbarPosition: FlushbarPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  void _showWithInput(BuildContext context) {
    Flushbar(
      title: 'Masukkan Sesuatu',
      message: 'Ini contoh flushbar dengan input form',
      userInputForm: Form(
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Ketik di sini...',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      duration: const Duration(seconds: 5),
    ).show(context);
  }

  void _showGradientFlushbar(BuildContext context) {
    Flushbar(
      titleText: const Text('Gradient Alert', style: TextStyle(color: Colors.white)),
      messageText: const Text('Flushbar dengan background gradasi dan ikon', style: TextStyle(color: Colors.white)),
      icon: const Icon(Icons.warning, size: 28, color: Colors.amber),
      backgroundGradient: const LinearGradient(colors: [Colors.deepPurple, Colors.black87]),
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 4),
    ).show(context);
  }

  void _showProgressFlushbar(BuildContext context) {
    Flushbar(
      title: 'Loading',
      message: 'Tunggu proses selesai...',
      showProgressIndicator: true,
      progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      duration: const Duration(seconds: 5),
    ).show(context);
  }

  void _showDismissFlushbar(BuildContext context) {
    Flushbar(
      title: 'Geser untuk Tutup',
      message: 'Flushbar ini bisa di-dismiss secara horizontal',
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      duration: const Duration(seconds: 4),
    ).show(context);
  }
}