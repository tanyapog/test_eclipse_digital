import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/inherited_user.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final company = InheritedUser.of(context).user.company;
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(company.name),
            subtitle: Text(company.bs),
          ),
          ListTile(
            leading: const Icon(Icons.format_quote_rounded, color: Colors.teal,),
            title: Text(company.catchPhrase, style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.blueGrey,
            ),)
          ),
        ],
      ),
    );
  }
}
