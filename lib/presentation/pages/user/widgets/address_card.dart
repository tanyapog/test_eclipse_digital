import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/model/user/address.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key, required this.address}) : super(key: key);
  final Address address;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: const Icon(Icons.home),
        title: Text(address.street),
        subtitle: Text('${address.city}, ${address.suite}\n${address.zipcode}'),
        isThreeLine: true,
      ),
    );
  }
}
