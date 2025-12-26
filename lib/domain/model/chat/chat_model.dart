class ChatMessage {
  final String messageId;
  final String from;
  final String content;
  final int timestamp;
  bool isRead;

  ChatMessage({
    required this.messageId,
    required this.from,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() => {
    'messageId': messageId,
    'from': from,
    'content': content,
    'timestamp': timestamp,
    'isRead': isRead,
  };

  static ChatMessage fromJson(Map data) => ChatMessage(
    messageId: data['messageId'],
    from: data['from'],
    content: data['content'],
    timestamp: data['timestamp'],
    isRead: data['isRead'] ?? false,
  );
}
