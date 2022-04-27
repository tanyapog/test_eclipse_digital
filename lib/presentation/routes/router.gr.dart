// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../pages/user/user_page.dart' as _i2;
import '../pages/user/users_overview_page.dart' as _i1;

class Router extends _i3.RootStackRouter {
  Router([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    UsersOverviewRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.UsersOverviewPage());
    },
    UserRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.UserPage());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(UsersOverviewRoute.name, path: '/'),
        _i3.RouteConfig(UserRoute.name, path: '/user-page')
      ];
}

/// generated route for
/// [_i1.UsersOverviewPage]
class UsersOverviewRoute extends _i3.PageRouteInfo<void> {
  const UsersOverviewRoute() : super(UsersOverviewRoute.name, path: '/');

  static const String name = 'UsersOverviewRoute';
}

/// generated route for
/// [_i2.UserPage]
class UserRoute extends _i3.PageRouteInfo<void> {
  const UserRoute() : super(UserRoute.name, path: '/user-page');

  static const String name = 'UserRoute';
}
