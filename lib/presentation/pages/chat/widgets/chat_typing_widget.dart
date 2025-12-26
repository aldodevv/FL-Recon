import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recon/core/services/socketio_service.dart';
import 'package:recon/presentation/pages/chat/chat_colors.dart';

class ChatTypingWidget extends StatefulWidget {
  final SocketService socket;

  const ChatTypingWidget({super.key, required this.socket});

  @override
  State<ChatTypingWidget> createState() => _ChatTypingWidgetState();
}

class _ChatTypingWidgetState extends State<ChatTypingWidget> {
  late Timer _timer;
  int _dotCount = 1;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        _dotCount = _dotCount == 3 ? 1 : _dotCount + 1;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.socket.isTyping,
      builder: (_, typing, _) {
        if (!typing) return const SizedBox(height: 8);

        return Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 120,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: ChatColors.appBar,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Text(
                    'Typing',
                    style: const TextStyle(
                      fontSize: 12,
                      letterSpacing: 2,
                      color: ChatColors.surface,
                    ),
                  ),
                  Text(
                    '.' * _dotCount,
                    style: const TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      color: ChatColors.surface,
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
}
