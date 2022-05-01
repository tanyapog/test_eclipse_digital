// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../model/post/post.dart' as _i9;
import '../../model/user/user.dart' as _i8;
import '../pages/album/albums_overview_page.dart' as _i5;
import '../pages/post/%20posts_overview_page.dart' as _i3;
import '../pages/post/post_page.dart' as _i4;
import '../pages/user/user_page.dart' as _i2;
import '../pages/user/users_overview_page.dart' as _i1;

class Router extends _i6.RootStackRouter {
  Router([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    UsersOverviewRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.UsersOverviewPage());
    },
    UserRoute.name: (routeData) {
      final args = routeData.argsAs<UserRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.UserPage(key: args.key, user: args.user));
    },
    PostsOverviewRoute.name: (routeData) {
      final args = routeData.argsAs<PostsOverviewRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.PostsOverviewPage(key: args.key, userId: args.userId));
    },
    PostRoute.name: (routeData) {
      final args = routeData.argsAs<PostRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.PostPage(key: args.key, post: args.post));
    },
    AlbumsOverviewRoute.name: (routeData) {
      final args = routeData.argsAs<AlbumsOverviewRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.AlbumsOverviewPage(key: args.key, userId: args.userId));
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(UsersOverviewRoute.name, path: '/'),
        _i6.RouteConfig(UserRoute.name, path: '/user-page'),
        _i6.RouteConfig(PostsOverviewRoute.name, path: '/posts-overview-page'),
        _i6.RouteConfig(PostRoute.name, path: '/post-page'),
        _i6.RouteConfig(AlbumsOverviewRoute.name, path: '/albums-overview-page')
      ];
}

/// generated route for
/// [_i1.UsersOverviewPage]
class UsersOverviewRoute extends _i6.PageRouteInfo<void> {
  const UsersOverviewRoute() : super(UsersOverviewRoute.name, path: '/');

  static const String name = 'UsersOverviewRoute';
}

/// generated route for
/// [_i2.UserPage]
class UserRoute extends _i6.PageRouteInfo<UserRouteArgs> {
  UserRoute({_i7.Key? key, required _i8.User user})
      : super(UserRoute.name,
            path: '/user-page', args: UserRouteArgs(key: key, user: user));

  static const String name = 'UserRoute';
}

class UserRouteArgs {
  const UserRouteArgs({this.key, required this.user});

  final _i7.Key? key;

  final _i8.User user;

  @override
  String toString() {
    return 'UserRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i3.PostsOverviewPage]
class PostsOverviewRoute extends _i6.PageRouteInfo<PostsOverviewRouteArgs> {
  PostsOverviewRoute({_i7.Key? key, required int userId})
      : super(PostsOverviewRoute.name,
            path: '/posts-overview-page',
            args: PostsOverviewRouteArgs(key: key, userId: userId));

  static const String name = 'PostsOverviewRoute';
}

class PostsOverviewRouteArgs {
  const PostsOverviewRouteArgs({this.key, required this.userId});

  final _i7.Key? key;

  final int userId;

  @override
  String toString() {
    return 'PostsOverviewRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i4.PostPage]
class PostRoute extends _i6.PageRouteInfo<PostRouteArgs> {
  PostRoute({_i7.Key? key, required _i9.Post post})
      : super(PostRoute.name,
            path: '/post-page', args: PostRouteArgs(key: key, post: post));

  static const String name = 'PostRoute';
}

class PostRouteArgs {
  const PostRouteArgs({this.key, required this.post});

  final _i7.Key? key;

  final _i9.Post post;

  @override
  String toString() {
    return 'PostRouteArgs{key: $key, post: $post}';
  }
}

/// generated route for
/// [_i5.AlbumsOverviewPage]
class AlbumsOverviewRoute extends _i6.PageRouteInfo<AlbumsOverviewRouteArgs> {
  AlbumsOverviewRoute({_i7.Key? key, required int userId})
      : super(AlbumsOverviewRoute.name,
            path: '/albums-overview-page',
            args: AlbumsOverviewRouteArgs(key: key, userId: userId));

  static const String name = 'AlbumsOverviewRoute';
}

class AlbumsOverviewRouteArgs {
  const AlbumsOverviewRouteArgs({this.key, required this.userId});

  final _i7.Key? key;

  final int userId;

  @override
  String toString() {
    return 'AlbumsOverviewRouteArgs{key: $key, userId: $userId}';
  }
}
