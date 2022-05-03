import 'dart:math';
import 'package:hive/hive.dart';

part 'comment.g.dart';

@HiveType(typeId: 5)
class Comment {
  @HiveField(0)
  final int postId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String email;
  @HiveField(4)
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


