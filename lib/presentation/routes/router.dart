import 'package:auto_route/annotations.dart';
import 'package:test_eclipse_digital/presentation/pages/user/user_page.dart';
import 'package:test_eclipse_digital/presentation/pages/user/users_overview_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute> [
    MaterialRoute(page: UsersOverviewPage, initial: true),
    MaterialRoute(page: UserPage),
  ]
)
class $Router {}
