// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../../model/user/user.dart' as _i6;
import '../pages/post/%20posts_overview_page.dart' as _i3;
import '../pages/user/user_page.dart' as _i2;
import '../pages/user/users_overview_page.dart' as _i1;

class Router extends _i4.RootStackRouter {
  Router([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    UsersOverviewRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.UsersOverviewPage());
    },
    UserRoute.name: (routeData) {
      final args = routeData.argsAs<UserRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.UserPage(key: args.key, user: args.user));
    },
    PostsOverviewRoute.name: (routeData) {
      final args = routeData.argsAs<PostsOverviewRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.PostsOverviewPage(key: args.key, userId: args.userId));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(UsersOverviewRoute.name, path: '/'),
        _i4.RouteConfig(UserRoute.name, path: '/user-page'),
        _i4.RouteConfig(PostsOverviewRoute.name, path: '/posts-overview-page')
      ];
}

/// generated route for
/// [_i1.UsersOverviewPage]
class UsersOverviewRoute extends _i4.PageRouteInfo<void> {
  const UsersOverviewRoute() : super(UsersOverviewRoute.name, path: '/');

  static const String name = 'UsersOverviewRoute';
}

/// generated route for
/// [_i2.UserPage]
class UserRoute extends _i4.PageRouteInfo<UserRouteArgs> {
  UserRoute({_i5.Key? key, required _i6.User user})
      : super(UserRoute.name,
            path: '/user-page', args: UserRouteArgs(key: key, user: user));

  static const String name = 'UserRoute';
}

class UserRouteArgs {
  const UserRouteArgs({this.key, required this.user});

  final _i5.Key? key;

  final _i6.User user;

  @override
  String toString() {
    return 'UserRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i3.PostsOverviewPage]
class PostsOverviewRoute extends _i4.PageRouteInfo<PostsOverviewRouteArgs> {
  PostsOverviewRoute({_i5.Key? key, required int userId})
      : super(PostsOverviewRoute.name,
            path: '/posts-overview-page',
            args: PostsOverviewRouteArgs(key: key, userId: userId));

  static const String name = 'PostsOverviewRoute';
}

class PostsOverviewRouteArgs {
  const PostsOverviewRouteArgs({this.key, required this.userId});

  final _i5.Key? key;

  final int userId;

  @override
  String toString() {
    return 'PostsOverviewRouteArgs{key: $key, userId: $userId}';
  }
}
