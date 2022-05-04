import 'dart:convert';
import 'package:test_eclipse_digital/infrastructure/hive_service.dart';
import 'package:test_eclipse_digital/main.dart';
import 'package:test_eclipse_digital/model/post/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  static final PostRepository _instance = PostRepository._internal();
  final hiveService = HiveService();
  final boxName = 'PostsBox';

  factory PostRepository() => _instance;

  PostRepository._internal();

  Future<List<Post>> fetchPosts(int userId) async {
    if (cachingIsOn)  {
      List<Post> posts = await hiveService.getAllFromBox<Post>(boxName)
        .onError((error, stackTrace) async {
          print("::: loading from $boxName for $userId failed: $error");
          return await _fetchFromJsonPlaceholder(userId);
        });
      if (posts.isEmpty) {
        posts = await _fetchFromJsonPlaceholder(userId);
        hiveService.addAllToBox<Post>(posts, boxName);
      }
      return posts;
    } else {
      return await _fetchFromJsonPlaceholder(userId);
    }
  }

  Future<List<Post>> _fetchFromJsonPlaceholder(int userId) async {
    print("::: posts for user $userId will be fetched from JsonPlaceholder");
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
