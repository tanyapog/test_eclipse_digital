import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/infrastructure/user_repository.dart';
import 'package:test_eclipse_digital/model/user/user.dart';
import 'package:test_eclipse_digital/presentation/custom_widgets/error_display.dart';

class UsersOverviewPage extends StatefulWidget {
  const UsersOverviewPage({Key? key}) : super(key: key);

  @override
  State<UsersOverviewPage> createState() => _UsersOverviewPageState();
}

class _UsersOverviewPageState extends State<UsersOverviewPage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserRepository().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return UsersOverviewBody(users: snapshot.data!,);
          } else if (snapshot.hasError) {
            return ErrorDisplay(
              error: 'Failed to load users',
              details: '${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }
      ),
    );
  }
}

class UsersOverviewBody extends StatelessWidget {
  final List<User> users;

  const UsersOverviewBody({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(users[i].username),
              subtitle: Text(users[i].name),
            ),
          )
        )
      ],
    );
  }
}

