import 'dart:async';
import 'package:flutter/material.dart';
import 'package:phone_state/phone_state.dart';

class PhoneCallHandler {
  StreamSubscription<PhoneState>? _subscription;
  final GlobalKey<NavigatorState> navigatorKey;

  PhoneCallHandler({required this.navigatorKey});

  void start() {
    debugPrint("📞 PhoneCallHandler START");
    _subscription = PhoneState.stream.listen(_onEvent);
  }

  void pause() {
    debugPrint("⏸️ PhoneCallHandler PAUSE");
    _subscription?.pause();
  }

  void resume() {
    debugPrint("▶️ PhoneCallHandler RESUME");
    _subscription?.resume();
  }

  void dispose() {
    debugPrint("🗑️ PhoneCallHandler DISPOSE");
    _subscription?.cancel();
  }

  void _onEvent(PhoneState event) {
    if (event.status == PhoneStateStatus.CALL_INCOMING ||
        event.status == PhoneStateStatus.CALL_STARTED) {
      final context = navigatorKey.currentContext;
      if (context == null) return;

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("Incoming Call"),
              content: const Text(
                "Aktivitas diblokir karena ada panggilan masuk.",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
      );
    }
  }
}
