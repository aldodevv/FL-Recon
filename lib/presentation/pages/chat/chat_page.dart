import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recon/core/services/socketio_service.dart';
import 'package:recon/presentation/pages/chat/chat_controller.dart';
import 'package:recon/presentation/pages/chat/chat_id_utils.dart';
import 'package:recon/presentation/pages/chat/widgets/chat_appbar_widget.dart';
import 'package:recon/presentation/pages/chat/widgets/chat_input_widget.dart';
import 'package:recon/presentation/pages/chat/widgets/chat_list_widget.dart';
import 'package:recon/presentation/pages/chat/widgets/chat_typing_widget.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  final String myUserId;
  final String peerUserId;

  const ChatPage({super.key, required this.myUserId, required this.peerUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final SocketService socket;
  late final ChatReadController readController;

  late final String chatId;
  late final Box box;

  final controller = TextEditingController();
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    chatId = ChatIdUtil.build(widget.myUserId, widget.peerUserId);
    _init();
  }

  Future<void> _init() async {
    box = await Hive.openBox(chatId);

    socket = SocketService(
      userId: widget.myUserId,
      peerUserId: widget.peerUserId,
      chatId: chatId,
      box: box,
    );

    socket.connect();

    readController = ChatReadController(
      box: box,
      socket: socket,
      chatId: chatId,
      myUserId: widget.myUserId,
    );

    readController.init();

    if (mounted) {
      setState(() => _ready = true);
    }
  }

  @override
  void dispose() {
    readController.dispose();
    socket.disconnect();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: ChatAppBarWidget(socket: socket, peerUserId: widget.peerUserId),
      body: Column(
        children: [
          Expanded(child: ChatList(box: box, chatId: chatId, myUserId: widget.myUserId)),
          ChatTypingWidget(socket: socket),
          ChatInput(controller: controller, socket: socket),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
