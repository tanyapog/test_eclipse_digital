import 'dart:convert';

import 'package:test_eclipse_digital/model/album/album.dart';
import 'package:http/http.dart' as http;

class AlbumRepository {
  Future<List<Album>> fetchAlbums(int userId) async {
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
