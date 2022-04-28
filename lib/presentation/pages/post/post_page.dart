import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/model/post/post.dart';
import 'package:test_eclipse_digital/presentation/pages/post/widgets/Inherited_post.dart';

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
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Summary(),
              SizedBox(height: 8,),
              _PostBody(),
              // CommentsList(),
            ],
          ),
        ),
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
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600,),
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
        // style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300,),
      ),
    );
  }
}


