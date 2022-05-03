import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_eclipse_digital/model/user/user.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();

  factory UserRepository() => _instance;

  UserRepository._internal();
  
  Future<List<User>> fetchUsers() async {
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