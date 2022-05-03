import 'package:hive/hive.dart';

part 'album.g.dart';

@HiveType(typeId: 6)
class Album {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String,dynamic> json){
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}
