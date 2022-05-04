import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_eclipse_digital/infrastructure/hive_service.dart';
import 'package:test_eclipse_digital/model/album/photo.dart';

class PhotoRepository {
  static final PhotoRepository _instance = PhotoRepository._internal();
  final hiveService = HiveService();

  factory PhotoRepository() => _instance;

  PhotoRepository._internal();
  
  Future<List<Photo>> fetchPhotos(int albumId) async {
    final boxName = 'photos_a$albumId';
    List<Photo> photos = await hiveService.getAllFromBox<Photo>(boxName)
      .onError((error, stackTrace) async {
        print("::: loading from $boxName failed: $error");
        return await _fetchFromJsonPlaceholder(albumId);
      });
    if (photos.isEmpty) {
      photos = await _fetchFromJsonPlaceholder(albumId);
      hiveService.addAllToBox<Photo>(photos, boxName);
    }
    return photos;
  }

  Future<Photo> fetchCover(int albumId) async {
    const boxName = 'album_covers';
    final coverKey = '$albumId-cover';
    Photo? cachedCover = await hiveService.getFromBox(coverKey, boxName)
      .onError((error, stackTrace) async {
        print("::: loading $coverKey from $boxName failed: $error");
        return (await fetchPhotos(albumId)).first;
      });
    if (cachedCover == null) {
      cachedCover = (await fetchPhotos(albumId)).first;
      await hiveService.putToBox(coverKey, cachedCover, boxName);
    }
    return cachedCover;
  }

  Future<List<Photo>> _fetchFromJsonPlaceholder(int albumId) async {
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
}
