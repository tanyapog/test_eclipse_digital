import 'dart:convert';

import 'package:test_eclipse_digital/model/comment/comment.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  Future<List<Comment>> fetchComments(int postId) async {
    final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
        .map((commentData) => Comment.fromJson(commentData))
        .where((comment) => comment.postId == postId)
        .toList();
    } else {
      throw Exception('Error while loading comments');
    }
  }
  
  Future<Comment> createComment(Comment comment) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
      body: jsonEncode(comment.toJson())
    );
    if (response.statusCode == 201) { // CREATED response
      return Comment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error while create a comment');
    }
  }
}