import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_eclipse_digital/infrastructure/hive_service.dart';
import 'package:test_eclipse_digital/model/user/user.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  final hiveService = HiveService();
  final boxName = 'UsersBox';

  factory UserRepository() => _instance;

  UserRepository._internal();
  
  Future<List<User>> fetchUsers() async {
    List<User> users;
    final usersCached = await hiveService.isCached(boxName: boxName);
    if (usersCached) {
      users = await hiveService.getAllFromBox<User>(boxName)
        // если ошибка, то загружаем из API
        .onError((error, stackTrace) async => await _fetchFromJsonPlaceholder());
    } else {
      users = await _fetchFromJsonPlaceholder();
      hiveService.addAllToBox<User>(users, boxName);
    }
    return users;
  }

  Future<List<User>> _fetchFromJsonPlaceholder() async {
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