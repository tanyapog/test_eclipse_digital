import 'dart:convert';
import 'package:test_eclipse_digital/infrastructure/hive_service.dart';
import 'package:test_eclipse_digital/model/album/album.dart';
import 'package:http/http.dart' as http;

class AlbumRepository {
  static final AlbumRepository _instance = AlbumRepository._internal();
  final hiveService = HiveService();
  final boxName = 'AlbumsBox';

  factory AlbumRepository() => _instance;

  AlbumRepository._internal();

  Future<List<Album>> fetchAlbums(int userId) async {
    List<Album> albums;
    final albumsCached = await hiveService.isCached(boxName: boxName);
    if (albumsCached) {
      albums = await hiveService.getAllFromBox<Album>(boxName)
        // если ошибка, то загружаем из API
        .onError((error, stackTrace) async => await _fetchFromJsonPlaceholder(userId));
    } else {
      albums = await _fetchFromJsonPlaceholder(userId);
      hiveService.addAllToBox<Album>(albums, boxName);
    }
    return albums;
  }

  Future<List<Album>> _fetchFromJsonPlaceholder(int userId) async {
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
