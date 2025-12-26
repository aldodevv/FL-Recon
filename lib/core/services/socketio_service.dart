import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:uuid/uuid.dart';

class SocketService {
  late io.Socket socket;
  final String userId;
  final String peerUserId;
  final String chatId;
  final ValueNotifier<bool> isOnline = ValueNotifier(false);
  final ValueNotifier<int?> lastSeen = ValueNotifier(null);
  final ValueNotifier<bool> isTyping = ValueNotifier(false);
  final Box box;

  bool _connected = false;

  SocketService({
    required this.userId,
    required this.chatId,
    required this.peerUserId,
    required this.box,
  });

  // ================= CONNECT =================
  void connect() {
    if (_connected) return;

    socket = io.io(
      'https://558ece54f253.ngrok-free.app',
      io.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build(),
    );

    socket.off('new_message', _onNewMessage);
    socket.off('message_read', _onRead);
    socket.off('typing', _onTyping);
    socket.off('message_deleted', _onDelete);
    socket.connect();

    socket.onConnect((_) {
      _connected = true;

      socket.emit('login', {'userId': userId});
      socket.emit('join_chat', {
        'chatId': chatId,
        'members': [userId],
      });
    });

    socket.on('new_message', _onNewMessage);
    socket.on('message_read', _onRead);
    socket.on('typing', _onTyping);
    socket.on('message_deleted', _onDelete);
    socket.on('user_online', _onSeenOnline);
    socket.on('user_offline', _onSeenOffline);
  }

  void disconnect() {
    if (!_connected) return;
    socket.disconnect();
    socket.dispose();
    _connected = false;
  }

  // ================= SEND =================

  void sendMessage(String text) {
    final msg = {
      'chatId': chatId,
      'messageId': const Uuid().v4(),
      'from': userId,
      'content': text,
      'type': 'text',
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'isRead': false,
    };

    // ✅ sender simpan lokal
    _saveLocal(msg);

    // ✅ backend hanya broadcast ke receiver
    socket.emit('send_message', msg);
  }

  void deleteMessage(String messageId) {
    socket.emit('delete_message', {'chatId': chatId, 'messageId': messageId, 'by': userId});
    _deleteLocal(messageId);
  }

  void typing(bool value) {
    socket.emit('typing', {'chatId': chatId, 'from': userId, 'isTyping': value});
  }

  void readMessage(String messageId) {
    socket.emit('read_message', {'chatId': chatId, 'messageId': messageId, 'readerId': userId});
  }

  // ================= LOCAL STORAGE =================

  void _saveLocal(Map msg) {
    final List list = List.from(box.get(chatId, defaultValue: []));

    // ❗ ANTI DUPLIKASI (PENTING)
    final exists = list.any((m) => m['messageId'] == msg['messageId']);
    if (exists) return;

    list.add(msg);
    box.put(chatId, list);
  }

  void _deleteLocal(String messageId) {
    final List list = List.from(box.get(chatId, defaultValue: []));
    list.removeWhere((e) => e['messageId'] == messageId);
    box.put(chatId, list);
  }

  // ================= SOCKET EVENTS =================

  /// Receiver ONLY (sender tidak akan dapat)
  void _onNewMessage(dynamic data) {
    _saveLocal(Map<String, dynamic>.from(data));
  }

  void _onDelete(dynamic data) {
    _deleteLocal(data['messageId']);
  }

  /// Sender terima read receipt
  void _onRead(dynamic data) {
    final List list = List.from(box.get(chatId, defaultValue: []));

    for (final m in list) {
      if (m['messageId'] == data['messageId']) {
        m['isRead'] = true;
      }
    }

    box.put(chatId, list);
  }

  void _onSeenOnline(dynamic data) {
    if (data['userId'] == peerUserId) {
      isOnline.value = true;
      lastSeen.value = null;
    }
  }

  void _onSeenOffline(dynamic data) {
    if (data['userId'] == peerUserId) {
      isOnline.value = false;
      lastSeen.value = data['lastSeen'];
    }
  }

  void _onTyping(dynamic data) {
    if (data['from'] != userId) {
      isTyping.value = data['isTyping'] == true;
    }
  }
}
