import 'dart:math';

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }

  factory Comment.forPost({
    required postId,
    required name,
    required email,
    required body,
  }) {
    print("pI = $postId, n = $name, e = $email, b = $body");
    return Comment(
    postId: postId,
    id: Random().nextInt(10000)+500,
    name: name,
    email: email,
    body: body,
  );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }
}


