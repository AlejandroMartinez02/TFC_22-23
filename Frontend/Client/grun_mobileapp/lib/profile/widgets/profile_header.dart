import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/profile_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
          top: size.height * 0.05,
          left: size.height * 0.03,
          bottom: size.height * 0.02),
      height: size.height * 0.2,
      alignment: Alignment.bottomLeft,
      width: size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Text(
        Constants.profileHeaderText(profileProvider.user.name),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 40),
      ),
    );
  }
}
