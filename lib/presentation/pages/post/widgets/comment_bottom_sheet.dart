import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/infrastructure/comment_repository.dart';
import 'package:test_eclipse_digital/model/comment/comment.dart';
import 'package:test_eclipse_digital/presentation/pages/post/widgets/Inherited_post.dart';

class CommentBottomSheet extends StatelessWidget {
  CommentBottomSheet({Key? key}) : super(key: key);

  final _commentFormKey = GlobalKey<FormState>();
  static final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).viewInsets,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Form(
        key: _commentFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(hintText: 'name'),
                    validator: (value) => (value == null || value.isEmpty)
                      ? 'Enter the name, please'
                      : null,
                    onSaved: (value) => _formData['name'] = value,
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'email'),
                    validator: (value) => (value == null || value.isEmpty)
                      ? 'Enter the email, please'
                      : null,
                    onSaved: (value) => _formData['email'] = value,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'leave comment...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(3),)
                ),
                maxLength: 1000,
                minLines: 3,
                maxLines: 3,
                validator: (value) => (value == null || value.isEmpty)
                  ? 'Type something'
                  : null,
                onSaved: (value) => _formData['body'] = value,
              ),
            ),
            _SendButton(formKey: _commentFormKey ,formData: _formData,),
          ],
      ),
    ));
  }
}

class _SendButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, dynamic> formData;

  const _SendButton({
    Key? key,
    required this.formKey,
    required this.formData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState?.save();
            await CommentRepository()
              .createComment(Comment.forPost(
                postId: InheritedPost.of(context).post.id,
                name: formData['name'],
                email: formData['email'],
                body: formData['body'],)
              );
            Navigator.of(context).pop();
          }
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}

