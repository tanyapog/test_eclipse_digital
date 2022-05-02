import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/model/user/user.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/address_card.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/albums_preview.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/company_card.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/inherited_user.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/minimalistic_tile.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/posts_preview.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.username),),
      body: SingleChildScrollView(
        child: InheritedUser(
          user: user,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: const Icon(Icons.person, size: 40, color: Colors.teal,),
                  title: Text(user.name, style: const TextStyle(fontSize: 26),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MinimalisticTile(leadingIcon: Icons.mail, text: user.email,),
                    MinimalisticTile(leadingIcon: Icons.phone, text: user.phone,),
                    MinimalisticTile(leadingIcon: Icons.public, text: user.website,),
                    const AddressCard(),
                    const CompanyCard(),
                  ],
                ),
              ),
              const Divider(color: Colors.black45,),
              const PostsPreview(),
              const Divider(color: Colors.black45,),
              const AlbumsPreview(),
            ],
          ),
        ),
      ),
    );
  }
}
