import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_eclipse_digital/infrastructure/hive_service.dart';
import 'package:test_eclipse_digital/main.dart';
import 'package:test_eclipse_digital/model/user/user.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  final hiveService = HiveService();

  factory UserRepository() => _instance;

  UserRepository._internal();
  
  Future<List<User>> fetchUsers() async {
    if (cachingIsOn)  {
      const boxName = 'users';
      List<User> users = await hiveService.getAllFromBox<User>(boxName)
        .onError((error, stackTrace) async {
          print("::: loading from $boxName failed: $error");
          return await _fetchFromJsonPlaceholder();
        });
      if (users.isEmpty) {
        users = await _fetchFromJsonPlaceholder();
        hiveService.addAllToBox<User>(users, boxName);
      }
      return users;
    } else {
      return await _fetchFromJsonPlaceholder();
    }
  }

  Future<List<User>> _fetchFromJsonPlaceholder() async {
    print("::: users will be fetched from JsonPlaceholder");
    final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
        .map((userData) => User.fromJson(userData))
        .toList();
    } else {
      throw Exception('Error while loading users');
    }
  }
}