import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recon/presentation/pages/chat/chat_colors.dart';

class ChatBubbleWidget extends StatelessWidget {
  final Map message;
  final bool isMe;

  const ChatBubbleWidget({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(message['timestamp']);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 100, // 👈 minimal width
            maxWidth: 300,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isMe ? ChatColors.layer : ChatColors.appBar,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isMe ? 16 : 4),
                bottomRight: Radius.circular(isMe ? 4 : 16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 🔥 penting
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  /// TEXT
                  Text(
                    message['content'],
                    style: const TextStyle(color: ChatColors.surface, fontSize: 15, height: 1.35),
                  ),

                  const SizedBox(height: 6),

                  /// TIME + READ (ROW TIDAK MEMAKSA LEBAR)
                  Row(
                    mainAxisSize: MainAxisSize.min, // 🔥 kunci utama
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(date),
                        textAlign: isMe ? TextAlign.end : TextAlign.start,
                        style: const TextStyle(fontSize: 11, color: ChatColors.surface),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 6),
                        Icon(
                          message['isRead'] == true ? Icons.done_all : Icons.done,
                          size: 16,
                          color: message['isRead'] == true ? Colors.blue : ChatColors.surface,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
