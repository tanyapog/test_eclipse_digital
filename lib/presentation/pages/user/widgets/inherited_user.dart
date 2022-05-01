import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/model/user/user.dart';

class InheritedUser extends InheritedWidget {
  final User user;

  const InheritedUser({
    Key? key,
    required this.user,
    required Widget child,
  }) : super(key: key, child: child);

  static InheritedUser of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<InheritedUser>();
    if (result != null) {
      return result;
    } else {
      throw Exception('User missing');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedUser oldWidget) =>
    user != oldWidget.user;
}
