import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/model/post/post.dart';

class InheritedPost extends InheritedWidget {
  final Post post;

  const InheritedPost({
    Key? key,
    required this.post,
    required Widget child,
  }) : super(key: key, child: child);

  static InheritedPost of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<InheritedPost>();
    if (result != null) {
      return result;
    } else {
      throw Exception('Post missing');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedPost oldWidget) =>
    post != oldWidget.post;
}
