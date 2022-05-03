import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/inherited_user.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final address = InheritedUser.of(context).user.address;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Icon(Icons.home, size: 18, color: Colors.black45,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${address.street}, ${address.suite}',),
              Text('${address.city}, ${address.zipcode}', ),
            ],
          ),
        ),
      ],
    );
  }
}
