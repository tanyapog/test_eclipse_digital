import 'dart:convert';

import 'package:test_eclipse_digital/model/post/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<Post>> fetchPosts(int userId) async {
    final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
        .map((postData) => Post.fromJson(postData))
        .where((post) => post.userId == userId)
        .toList();
    } else {
      throw Exception('Error while loading posts');
    }
  }
}
