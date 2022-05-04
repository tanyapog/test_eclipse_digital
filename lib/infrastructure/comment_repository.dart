import 'dart:convert';
import 'package:test_eclipse_digital/infrastructure/hive_service.dart';
import 'package:test_eclipse_digital/main.dart';
import 'package:test_eclipse_digital/model/comment/comment.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  static final CommentRepository _instance = CommentRepository._internal();
  final hiveService = HiveService();
  final boxName = 'CommentsBox';

  factory CommentRepository() => _instance;

  CommentRepository._internal();
  
  Future<List<Comment>> fetchComments(int postId) async {
    if (cachingIsOn)  {
      List<Comment> comments = await hiveService.getAllFromBox<Comment>(boxName)
        .onError((error, stackTrace) async {
          print("::: loading from $boxName for $postId failed: $error");
          return await _fetchFromJsonPlaceholder(postId);
        });
      if (comments.isEmpty) {
        comments = await _fetchFromJsonPlaceholder(postId);
        hiveService.addAllToBox<Comment>(comments, boxName);
      }
      return comments;
    } else {
      return await _fetchFromJsonPlaceholder(postId);
    }
  }

  Future<List<Comment>> _fetchFromJsonPlaceholder(int postId) async {
    print("::: comments for post $postId will be fetched from JsonPlaceholder");
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
      // если бы коммент добавлялся по настоящему, то его нужно было бы сразу закэшировать
      // hiveService.addToBox(comment, boxName);
      return Comment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error while create a comment');
    }
  }
}