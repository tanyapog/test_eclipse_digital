import 'dart:convert';
import 'package:test_eclipse_digital/infrastructure/hive_service.dart';
import 'package:test_eclipse_digital/model/album/album.dart';
import 'package:http/http.dart' as http;

class AlbumRepository {
  static final AlbumRepository _instance = AlbumRepository._internal();
  final hiveService = HiveService();

  factory AlbumRepository() => _instance;

  AlbumRepository._internal();

  Future<List<Album>> fetchAlbums(int userId) async {
    final boxName = 'albums_u$userId';
    List<Album> albums = await hiveService.getAllFromBox<Album>(boxName)
      .onError((error, stackTrace) async {
        print("::: loading from $boxName failed: $error");
        return await _fetchFromJsonPlaceholder(userId);
      });
    if (albums.isEmpty) {
      albums = await _fetchFromJsonPlaceholder(userId);
      hiveService.addAllToBox<Album>(albums, boxName);
    }
    return albums;
  }

  Future<List<Album>> _fetchFromJsonPlaceholder(int userId) async {
    print("::: albums for user $userId will be fetched from JsonPlaceholder");
    final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
        .map((albumData) => Album.fromJson(albumData))
        .where((album) => album.userId == userId)
        .toList();
    } else {
      throw Exception('Error while loading albums');
    }
  }
}
