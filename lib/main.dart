import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/presentation/routes/router.gr.dart' as app_router;

void main() async {
  // всё необходимое для кэширования
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CompanyAdapter());
  Hive.registerAdapter(AddressAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = app_router.Router();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Test task for Eclipse Digital',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
