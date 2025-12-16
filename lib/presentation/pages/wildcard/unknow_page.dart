import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recon/presentation/widgets/button/mainbutton_widget.dart';

@RoutePage()
class UnknowPage extends StatelessWidget {
  const UnknowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unknow Page'),
        leading: AutoLeadingButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Unknow Page, halaman tidak ditemukan atau tidak tersedia di aplikasi ini untuk saat ini :(',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 8),
          MainbuttonWidget(
            text: 'Kembali',
            onPressed: () => context.router.pop(),
          ),
        ],
      ),
    );
  }
}
