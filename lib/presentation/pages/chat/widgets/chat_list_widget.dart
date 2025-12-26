import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recon/presentation/pages/chat/widgets/chat_bubble_widget.dart';
import 'package:recon/presentation/pages/chat/widgets/chat_date_separator_widget.dart';

class ChatList extends StatelessWidget {
  final Box box;
  final String chatId;
  final String myUserId;

  const ChatList({super.key, required this.box, required this.chatId, required this.myUserId});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(keys: [chatId]),
      builder: (_, Box box, _) {
        List messages = List.from(box.get(chatId, defaultValue: []));
        messages.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

        String? lastDate;

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: messages.length,
          itemBuilder: (_, i) {
            final m = messages[i];
            final date = DateTime.fromMillisecondsSinceEpoch(m['timestamp']);
            final label = ChatDateSeparator.labeling(date);

            final showDate = label != lastDate;
            lastDate = label;

            return Column(
              children: [
                if (showDate) ChatDateSeparator(label: label),
                ChatBubbleWidget(message: m, isMe: m['from'] == myUserId),
              ],
            );
          },
        );
      },
    );
  }
}
