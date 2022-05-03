import 'package:hive/hive.dart';

part 'address.g.dart';

@HiveType(typeId: 3)
class Address {
  @HiveField(0)
  final String street;
  @HiveField(1)
  final String suite;
  @HiveField(2)
  final String city;
  @HiveField(3)
  final String zipcode;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
    );
  }
}