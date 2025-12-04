import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkHandler {
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void start() {
    debugPrint("🌐 NetworkHandler START");

    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      if (results.isEmpty) return;
      final status = results.first;
      debugPrint("🌐 Network Status: $status");

      if (status == ConnectivityResult.none) {
        debugPrint("❌ Internet MATI");
      } else {
        debugPrint("✅ Internet HIDUP via ${status.name}");
      }
    });
  }

  void pause() {
    debugPrint("⏸️ NetworkHandler PAUSE");
    _subscription?.pause();
  }

  void resume() {
    debugPrint("▶️ NetworkHandler RESUME");
    _subscription?.resume();
  }

  void dispose() {
    debugPrint("🗑️ NetworkHandler DISPOSE");
    _subscription?.cancel();
  }
}
