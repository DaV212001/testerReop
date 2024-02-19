class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.body,
    required this.id,
    required this.title,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      body: json['body'],
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
    );
  }
}
