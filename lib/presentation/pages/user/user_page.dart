import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_eclipse_digital/model/user/user.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/address_card.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/company_card.dart';
import 'package:test_eclipse_digital/presentation/pages/user/widgets/inherited_user.dart';
import 'package:test_eclipse_digital/presentation/routes/router.gr.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.username),),
      body: InheritedUser(
        user: user,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 10,
              child: Column(
                children: [
                  ListTile(
                    title: Text(user.name),
                    subtitle: Text('${user.email}\n${user.phone}'),
                    isThreeLine: true,
                  ),
                  ListTile(
                    leading: const Icon(Icons.public),
                    title: RichText(
                      text: TextSpan(
                        text: user.website,
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _launchUrl(Uri.parse(user.website)),
                      ),
                    )
                  ),
                ],
              ),
            ),
            const CompanyCard(),
            const AddressCard(),
            Row(
              children: [
                TextButton(onPressed: () => AutoRouter.of(context)
                    .push(PostsOverviewRoute(userId: user.id)),
                  child: const Text('Posts'),
                ),
                const SizedBox(width: 10,),
                TextButton(onPressed: () => AutoRouter.of(context)
                    .push(AlbumsOverviewRoute(userId: user.id)),
                  child: const Text('Albums'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _launchUrl(Uri url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }
}
