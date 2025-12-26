import 'package:hive_flutter/hive_flutter.dart';
import 'package:recon/core/services/socketio_service.dart';

class ChatReadController {
  final Box box;
  final SocketService socket;
  final String chatId;
  final String myUserId;

  final Set<String> _readSent = {};

  ChatReadController({
    required this.box,
    required this.socket,
    required this.chatId,
    required this.myUserId,
  });

  void init() {
    _markAllAsRead();
    box.listenable(keys: [chatId]).addListener(_onChatUpdated);
  }

  void dispose() {
    box.listenable(keys: [chatId]).removeListener(_onChatUpdated);
  }

  void _onChatUpdated() {
    _markAllAsRead();
  }

  void _markAllAsRead() {
    final List messages = List.from(box.get(chatId, defaultValue: []));

    for (final m in messages) {
      if (m['from'] != myUserId && m['isRead'] != true && !_readSent.contains(m['messageId'])) {
        _readSent.add(m['messageId']);
        socket.readMessage(m['messageId']);
      }
    }
  }
}
