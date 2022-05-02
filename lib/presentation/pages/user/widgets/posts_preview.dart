import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/presentation/custom_widgets/warning_display.dart';
import 'package:test_eclipse_digital/presentation/pages/post/widgets/Inherited_post.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/inherited_user.dart';
import 'package:test_eclipse_digital/presentation/routes/router.gr.dart';
import 'package:test_eclipse_digital/infrastructure/post_repository.dart';
import 'package:test_eclipse_digital/model/post/post.dart';

class PostsPreview extends StatefulWidget {
  const PostsPreview({Key? key}) : super(key: key);

  @override
  State<PostsPreview> createState() => _PostsPreviewState();
}

class _PostsPreviewState extends State<PostsPreview> {
  late Future<List<Post>> futurePosts;
  late int userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userId = InheritedUser.of(context).user.id;
    futurePosts = PostRepository().fetchPosts(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => AutoRouter.of(context)
            .push(PostsOverviewRoute(userId: userId)),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 20, 10),
            child: Text('Publications...', style: TextStyle(fontSize: 16),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: FutureBuilder<List<Post>>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 160,
                    child: ListView.separated(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, i) =>
                        InheritedPost(
                          post: snapshot.data![i],
                          child: const _PostPreviewTile(),
                        ),
                      separatorBuilder: (context, i) =>
                        const SizedBox(width: 10),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const WarningDisplay(message: "Can not load posts preview :(",);
                }
                return const Center(child: CircularProgressIndicator());
              }
          ),
        ),
      ],
    );
  }
}

class _PostPreviewTile extends StatelessWidget {
  const _PostPreviewTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = InheritedPost.of(context).post;
    return InkWell(
      onTap: () => AutoRouter.of(context)
          .push(PostRoute(post: post)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                width: double.infinity,
                height: 40,
                color: Theme.of(context).primaryColor,
                child: Text(post.title,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(post.body,
                  style: const TextStyle(color: Colors.black45),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}