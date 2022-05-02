import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/infrastructure/album_repository.dart';
import 'package:test_eclipse_digital/model/album/album.dart';
import 'package:test_eclipse_digital/presentation/custom_widgets/error_display.dart';
import 'package:test_eclipse_digital/presentation/pages/album/widgets/album_cover.dart';
import 'package:test_eclipse_digital/presentation/routes/router.gr.dart';

class AlbumsOverviewPage extends StatefulWidget {
  final int userId;
  const AlbumsOverviewPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<AlbumsOverviewPage> createState() => _AlbumsOverviewPageState();
}

class _AlbumsOverviewPageState extends State<AlbumsOverviewPage> {
  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = AlbumRepository().fetchAlbums(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  const Text('Albums'),),
      body: FutureBuilder<List<Album>>(
        future: futureAlbums,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _AlbumsOverviewBody(albums: snapshot.data!);
          } else if (snapshot.hasError) {
            return ErrorDisplay(
              error: 'Failed to load albums',
              details: '${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _AlbumsOverviewBody extends StatelessWidget {
  final List<Album> albums;
  const _AlbumsOverviewBody({Key? key, required this.albums}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, i) => Column(
                children: [
                  ListTile(
                    onTap: () => AutoRouter.of(context).push(AlbumRoute(album: albums[i])),
                    leading: AlbumCover.rounded(albumId: albums[i].id,),
                    title: Text(albums[i].title),
                  ),
                  const SizedBox(height: 8,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

