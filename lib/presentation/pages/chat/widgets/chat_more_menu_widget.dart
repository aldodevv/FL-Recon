import 'package:flutter/material.dart';

class ChatMoreMenu extends StatelessWidget {
  const ChatMoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert),
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder:
          (context) => [
            _item(0, Icons.search, 'Search'),
            _item(1, Icons.notifications_off, 'Mute'),
            _item(2, Icons.delete_outline, 'Clear chat'),
            _item(3, Icons.info_outline, 'Info'),
          ],
      onSelected: (value) {
        switch (value) {
          case 0:
            // search
            break;
          case 1:
            // mute
            break;
          case 2:
            // clear chat
            break;
          case 3:
            // info
            break;
        }
      },
    );
  }

  PopupMenuItem<int> _item(int value, IconData icon, String text) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(children: [Icon(icon, size: 20), const SizedBox(width: 12), Text(text)]),
    );
  }
}
