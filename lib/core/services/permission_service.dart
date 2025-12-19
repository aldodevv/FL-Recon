import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

enum PermissionEventType { updated, permanentlyDenied, allCompleted }

class PermissionEvent {
  final PermissionEventType type;
  final Permission? permission;
  final Map<Permission, PermissionStatus> status;

  PermissionEvent({required this.type, required this.status, this.permission});
}

class PermissionService {
  final _controller = StreamController<PermissionEvent>.broadcast();
  Stream<PermissionEvent> get events => _controller.stream;

  late final List<Permission> _permissions;

  PermissionService() {
    _permissions = [Permission.camera, Permission.location, Permission.notification];

    checkAll();
  }

  Future<Map<Permission, PermissionStatus>> checkAll() async {
    final result = <Permission, PermissionStatus>{};

    for (var p in _permissions) {
      result[p] = await p.status;
    }

    _safeAddEvent(PermissionEvent(type: PermissionEventType.updated, status: result));

    return result;
  }

  Future<void> requestAll() async {
    final Map<Permission, PermissionStatus> finalResult = {};

    for (var p in _permissions) {
      final status = await p.request();
      finalResult[p] = status;
    }

    _safeAddEvent(PermissionEvent(type: PermissionEventType.allCompleted, status: finalResult));

    for (var entry in finalResult.entries) {
      if (entry.value.isPermanentlyDenied) {
        _safeAddEvent(
          PermissionEvent(
            type: PermissionEventType.permanentlyDenied,
            permission: entry.key,
            status: finalResult,
          ),
        );
      }
    }
  }

  void _safeAddEvent(PermissionEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  void dispose() {
    if (!_controller.isClosed) {
      _controller.close();
    }
  }
}
