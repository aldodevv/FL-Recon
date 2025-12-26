import 'package:flutter/material.dart';
import 'package:recon/core/services/socketio_service.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final SocketService socket;

  const ChatInput({super.key, required this.controller, required this.socket});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (v) => socket.typing(v.isNotEmpty),
              decoration: const InputDecoration(
                hintText: 'Ketik pesan...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final text = controller.text.trim();
              if (text.isEmpty) return;
              socket.sendMessage(text);
              controller.clear();
              socket.typing(false);
            },
          ),
        ],
      ),
    );
  }
}
