import 'dart:io';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';

Future<void> showStartChatSheet(BuildContext context) async {
  debugPrint('asede');
  final myController = TextEditingController();
  final peerController = TextEditingController();
  myController.text = await getDeviceName();

  showModalBottomSheet(
    context: context,
    useRootNavigator: true, // 🔥 PENTING
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return AnimatedPadding(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Start Chat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: myController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Your Name'),
                ),

                const SizedBox(height: 12),

                TextField(
                  controller: peerController,
                  decoration: const InputDecoration(labelText: 'Chat With'),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      context.router.pop();
                      context.router.push(
                        ChatRoute(myUserId: myController.text, peerUserId: peerController.text),
                      );
                    },
                    child: const Text('Start Chat'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<String> getDeviceName() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final info = await deviceInfo.androidInfo;
    return info.brand;
  }

  if (Platform.isIOS) {
    final info = await deviceInfo.iosInfo;
    return info.name;
  }

  return 'Unknown Device';
}
