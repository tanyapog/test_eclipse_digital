import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/model/post/post.dart';
import 'package:test_eclipse_digital/presentation/pages/post/widgets/Inherited_post.dart';
import 'package:test_eclipse_digital/presentation/pages/post/widgets/comment_bottom_sheet.dart';
import 'package:test_eclipse_digital/presentation/pages/post/widgets/comments_list.dart';

class PostPage extends StatelessWidget {
  final Post post;
  const PostPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title),),
      body: InheritedPost(
        post: post,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Summary(),
              const SizedBox(height: 8,),
              const _PostBody(),
              Flexible(
                child: CommentsList(postId: post.id)
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => InheritedPost(
            post: post,
            child: CommentBottomSheet(),
          ),
        ),
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        InheritedPost.of(context).post.title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.teal),
      ),
    );
  }
}

class _PostBody extends StatelessWidget {
  const _PostBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        InheritedPost.of(context).post.body,
        style: const TextStyle(fontSize: 16,),
      ),
    );
  }
}


