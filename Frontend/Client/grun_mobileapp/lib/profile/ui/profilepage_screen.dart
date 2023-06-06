import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../utils/widgets/loading_screen.dart';
import '../../utils/widgets/not_found_page.dart';
import '../widgets/widgets.dart';
import 'profile_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final size = MediaQuery.of(context).size;

    if (profileProvider.isLoading) return const LoadingScreen();

    return profileProvider.user.id == Constants.error
        ? Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
              child: const NotFoundPage(
                message: Constants.errorPageText,
              ),
            ),
          )
        : const Scaffold(
            body: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(),
                MyOrderOption(),
                PersonalDataButton(),
              ],
            ),
            LogoutButton()
          ]));
  }
}
