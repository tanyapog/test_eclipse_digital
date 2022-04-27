import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/model/user/company.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({Key? key, required this.company}) : super(key: key);
  final Company company;

  @override
  Widget build(BuildContext context) {
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
