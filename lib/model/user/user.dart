import 'package:hive_flutter/adapters.dart';
import 'package:test_eclipse_digital/model/user/address.dart';
import 'package:test_eclipse_digital/model/user/company.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String website;
  @HiveField(6)
  final Company company;
  @HiveField(7)
  final Address address;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.company,
    required this.address
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      company: Company.fromJson(json['company']),
      address: Address.fromJson(json['address']),
    );
  }
}


