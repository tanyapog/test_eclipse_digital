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
}