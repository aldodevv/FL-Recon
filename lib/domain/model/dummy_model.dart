class ResponsePost {
  final int id;
  final int userId;
  final String title;
  final String body;

  ResponsePost({required this.id, required this.userId, required this.title, required this.body});

  factory ResponsePost.from(dynamic json) {
    return ResponsePost(id: json['id'], userId: json['userId'], title: json['title'], body: json['body']);
  }
}
