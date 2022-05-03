import 'dart:convert';
import 'package:test_eclipse_digital/infrastructure/hive_service.dart';
import 'package:test_eclipse_digital/model/post/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  static final PostRepository _instance = PostRepository._internal();
  final hiveService = HiveService();
  final boxName = 'PostsBox';

  factory PostRepository() => _instance;

  PostRepository._internal();

  Future<List<Post>> fetchPosts(int userId) async {
    List<Post> posts;
    final postsCached = await hiveService.isCached(boxName: boxName);
    if (postsCached) {
      posts = await hiveService.getAllFromBox<Post>(boxName)
        // если ошибка, то загружаем из API
        .onError((error, stackTrace) async => await _fetchFromJsonPlaceholder(userId));
    } else {
      posts = await _fetchFromJsonPlaceholder(userId);
      hiveService.addAllToBox<Post>(posts, boxName);
    }
    return posts;
  }

  Future<List<Post>> _fetchFromJsonPlaceholder(int userId) async {
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
