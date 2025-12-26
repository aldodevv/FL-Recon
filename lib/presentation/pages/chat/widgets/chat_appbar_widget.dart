import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recon/core/services/socketio_service.dart';
import 'package:recon/presentation/pages/chat/chat_colors.dart';
import 'package:recon/presentation/pages/chat/widgets/chat_more_menu_widget.dart';

class ChatAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final SocketService socket;
  final String peerUserId;

  const ChatAppBarWidget({super.key, required this.socket, required this.peerUserId});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ChatColors.appBar,
      elevation: 0,
      titleSpacing: 0,
      iconTheme: const IconThemeData(color: ChatColors.surface),
      title: Row(
        children: [
          const SizedBox(width: 8),

          /// AVATAR
          const CircleAvatar(
            radius: 18,
            backgroundColor: ChatColors.layer,
            child: Icon(Icons.person, color: ChatColors.surface),
          ),

          const SizedBox(width: 12),

          /// NAME + STATUS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  peerUserId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: ChatColors.surface,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                ValueListenableBuilder<bool>(
                  valueListenable: socket.isOnline,
                  builder: (_, online, _) {
                    if (online) {
                      return Row(
                        children: const [
                          Icon(Icons.circle, size: 8, color: ChatColors.online),
                          SizedBox(width: 4),
                          Text(
                            'online',
                            style: TextStyle(fontSize: 12, color: ChatColors.highlight),
                          ),
                        ],
                      );
                    }

                    return ValueListenableBuilder<int?>(
                      valueListenable: socket.lastSeen,
                      builder: (_, ts, _) {
                        if (ts == null) return const SizedBox();
                        return Text(
                          'last seen ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(ts))}',
                          style: const TextStyle(fontSize: 12, color: ChatColors.muted),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          /// MENU
          const ChatMoreMenu(),

          const SizedBox(width: 4),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ChatColors.dark.withAlpha(20), ChatColors.layer.withAlpha(40)],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
