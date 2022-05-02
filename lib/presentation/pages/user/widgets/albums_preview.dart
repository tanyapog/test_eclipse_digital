import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/presentation/custom_widgets/warning_display.dart';
import 'package:test_eclipse_digital/presentation/pages/album/widgets/album_cover.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/inherited_user.dart';
import 'package:test_eclipse_digital/presentation/routes/router.gr.dart';
import 'package:test_eclipse_digital/infrastructure/album_repository.dart';
import 'package:test_eclipse_digital/model/album/album.dart';

class AlbumsPreview extends StatefulWidget {
  const AlbumsPreview({Key? key}) : super(key: key);

  @override
  State<AlbumsPreview> createState() => _AlbumsPreviewState();
}

class _AlbumsPreviewState extends State<AlbumsPreview> {
  late Future<List<Album>> futureAlbums;
  late int userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userId = InheritedUser.of(context).user.id;
    futureAlbums = AlbumRepository().fetchAlbums(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => AutoRouter.of(context)
            .push(AlbumsOverviewRoute(userId: userId)),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 20, 10),
            child: Text('Albums...', style: TextStyle(fontSize: 16),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
          child: FutureBuilder<List<Album>>(
              future: futureAlbums,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 160,
                    child: ListView.separated(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, i) =>
                        _AlbumPreviewTile(album: snapshot.data![i],),
                      separatorBuilder: (context, i) =>
                        const SizedBox(width: 10),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const WarningDisplay(message: "Can not load albums preview :(",);
                }
                return const Center(child: CircularProgressIndicator());
              }
          ),
        ),
      ],
    );
  }
}

class _AlbumPreviewTile extends StatelessWidget {
  final Album album;
  const _AlbumPreviewTile({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AutoRouter.of(context)
        .push(AlbumRoute(album: album)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: 110,
          child: Column(
            children: <Widget>[
              AlbumCover(albumId: album.id,),
              Container(
                padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                width: double.infinity,
                height: 40,
                child: Text(album.title,
                  style: const TextStyle(fontSize: 16,),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
