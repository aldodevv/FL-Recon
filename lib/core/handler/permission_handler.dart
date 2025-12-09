import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recon/core/services/permission_service.dart';
import 'package:recon/presentation/widgets/modal/modal_permission_denied.dart';

class PermissionHandler {
  final GlobalKey<NavigatorState> navigatorKey;
  final PermissionService service;

  StreamSubscription<PermissionEvent>? _sub;

  PermissionHandler({
    required this.navigatorKey,
    required this.service,
  });

  void start() {
    _listenEvents();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      service.requestAll();
    });
  }

  void dispose() {
    _sub?.cancel();
  }

  void _listenEvents() {
    _sub = service.events.listen((event) {
      switch (event.type) {
        case PermissionEventType.allCompleted:
          _handleAllCompleted(event.status);
          break;

        case PermissionEventType.permanentlyDenied:
          _showModal([event.permission!]);
          break;

        default:
          break;
      }
    });
  }

  void _handleAllCompleted(Map<Permission, PermissionStatus> map) {
    final denied = map.entries
        .where((e) => !e.value.isGranted)
        .map((e) => e.key)
        .toList();

    if (denied.isNotEmpty) {
      _showModal(denied);
    }
  }

  void _showModal(List<Permission> denied) {
    final nav = navigatorKey.currentState;
    if (nav == null) return;

    nav.push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: false,
        pageBuilder: (_, __, ___) =>
            ModalPermissionDenied(denied: denied),
      ),
    );
  }
}
