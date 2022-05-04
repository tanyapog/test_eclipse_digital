import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_eclipse_digital/model/album/photo.dart';

class PhotoRepository {
  static final PhotoRepository _instance = PhotoRepository._internal();

  factory PhotoRepository() => _instance;

  PhotoRepository._internal();
  
  Future<List<Photo>> fetchPhotos(int albumId) async {
    print("::: photos for album $albumId will be fetched from JsonPlaceholder");
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((photoData) => Photo.fromJson(photoData))
          .where((album) => album.albumId == albumId)
          .toList();
    } else {
      throw Exception('Error while loading photos');
    }
  }

  Future<Photo> fetchFirst(int albumId) async {
    print("::: first photo for album $albumId will be fetched from JsonPlaceholder");
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((photoData) => Photo.fromJson(photoData))
          .where((album) => album.albumId == albumId)
          .toList()
          .first;
    } else {
      throw Exception('Error while loading photos');
    }
  }
}
