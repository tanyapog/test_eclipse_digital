import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/infrastructure/post_repository.dart';
import 'package:test_eclipse_digital/model/post/post.dart';
import 'package:test_eclipse_digital/presentation/custom_widgets/error_display.dart';

class PostsOverviewPage extends StatefulWidget {
  final int userId;
  const PostsOverviewPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<PostsOverviewPage> createState() => _PostsOverviewPageState();
}

class _PostsOverviewPageState extends State<PostsOverviewPage> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = PostRepository().fetchPosts(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Posts'),
      ),
      body: FutureBuilder<List<Post>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PostsOverviewBody(posts: snapshot.data!);
          } else if (snapshot.hasError) {
            return ErrorDisplay(
              error: 'Failed to load posts',
              details: '${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },

      ),
    );
  }
}

class PostsOverviewBody extends StatelessWidget {
  final List<Post> posts;

  const PostsOverviewBody({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: posts.length,
              itemBuilder: (context, i) => Card(
                elevation: 10,
                child: ListTile(
                  title: Text(posts[i].title),
                  subtitle: Text(posts[i].body,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,),
                  isThreeLine: true,
                ),
              ),
          ),
        ),
      ],
    );
  }
}

