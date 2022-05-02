import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/infrastructure/photo_repository.dart';
import 'package:test_eclipse_digital/model/album/photo.dart';

class AlbumCover extends StatefulWidget {
  final int albumId;
  final bool rounded;

  const AlbumCover({Key? key, required this.albumId, this.rounded = false}) : super(key: key);
  const AlbumCover.rounded({Key? key, required this.albumId, this.rounded = true}) : super(key: key);

  @override
  State<AlbumCover> createState() => _AlbumCoverState();
}

class _AlbumCoverState extends State<AlbumCover> {
  late Future<Photo> futureCover;

  @override
  void initState() {
    super.initState();
    futureCover = PhotoRepository().fetchFirst(widget.albumId);
  }

  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder<Photo>(
        future: futureCover,
        builder: (context, photoSnapshot) {
          if (photoSnapshot.hasData) {
            return ClipRRect(
              borderRadius: widget.rounded
                ? BorderRadius.circular(8)
                : BorderRadius.circular(0), //const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(photoSnapshot.data!.thumbnailUrl),
            );
          } else if (photoSnapshot.hasError) {
            return const Icon(Icons.preview);
          }
          return const CircularProgressIndicator();
        },
      );
  }
}