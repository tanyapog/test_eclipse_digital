import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/inherited_user.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final address = InheritedUser.of(context).user.address;
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
