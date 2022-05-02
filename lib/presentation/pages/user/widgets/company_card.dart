import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/inherited_user.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final company = InheritedUser.of(context).user.company;
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(company.name, style: const TextStyle(fontSize: 20),),
          Text(company.bs),
          ListTile(
            contentPadding: const EdgeInsets.all(0),
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
