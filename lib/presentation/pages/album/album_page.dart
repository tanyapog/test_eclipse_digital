import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/infrastructure/photo_repository.dart';
import 'package:test_eclipse_digital/model/album/album.dart';
import 'package:test_eclipse_digital/model/album/photo.dart';
import 'package:test_eclipse_digital/presentation/custom_widgets/error_display.dart';
import 'package:test_eclipse_digital/presentation/routes/router.gr.dart';

class AlbumPage extends StatefulWidget {
  final Album album;
  const AlbumPage({Key? key, required this.album}) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Future<List<Photo>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = PhotoRepository().fetchPhotos(widget.album.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 15),
            child: Text(widget.album.title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,),
            ),
          ),
          FutureBuilder<List<Photo>>(
            future: futurePhotos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _AlbumBody(photos: snapshot.data!);
              } else if (snapshot.hasError) {
                return ErrorDisplay(
                  error: 'Failed to load photos',
                  details: '${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      )
    );
  }
}

class _AlbumBody extends StatelessWidget {
  final List<Photo> photos;
  const _AlbumBody({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, i) => InkWell(
          onTap: () => AutoRouter.of(context)
            .push(PhotoCarouselRoute(photos: photos, startFrom: i)),
          child: _GridItem(photo: photos[i])
        ),
      )
    );
  }
}

class _GridItem extends StatelessWidget {
  final Photo photo;
  const _GridItem({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(photo.url, fit: BoxFit.cover,),
    );
  }
}

