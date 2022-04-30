import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/infrastructure/comment_repository.dart';
import 'package:test_eclipse_digital/model/comment/comment.dart';
import 'package:test_eclipse_digital/presentation/custom_widgets/error_display.dart';

class CommentsList extends StatefulWidget {
  final int postId;
  const CommentsList({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  late Future<List<Comment>> futureComments;

  @override
  void initState() {
    super.initState();
    futureComments = CommentRepository().fetchComments(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
      future: futureComments,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _CommentsListBody(comments: snapshot.data!,);
        } else if (snapshot.hasError) {
          return ErrorDisplay(
            error: 'Failed to load comments',
            details: '${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}

class _CommentsListBody extends StatelessWidget {
  final List<Comment> comments;
  const _CommentsListBody({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.comment, color:  Colors.teal,),
          trailing: Text(comments.length.toString(), style: const TextStyle(color: Colors.cyan),),
          title: const Text('Comments'),
        ),
        const Divider(thickness: 3),
        Flexible(
          child: ListView.builder(
            itemCount: comments.length,
            shrinkWrap: true,
            itemBuilder: (context, i) => _SingleComment(comment: comments[i]),
          ),
        ),
      ],
    );
  }
}

class _SingleComment extends StatelessWidget {
  final Comment comment;
  const _SingleComment({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle_sharp),
            title: Text(comment.name),
            subtitle: Text(comment.email, style: const TextStyle(color: Colors.blueGrey),),
          ),
          Text(comment.body, style: const TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),),
          const Divider(color: Colors.black45,),
        ],
      )
    );
  }
}


