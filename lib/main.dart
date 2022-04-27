import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/presentation/pages/user/users_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test task for Eclipse Digital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UsersOverviewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
