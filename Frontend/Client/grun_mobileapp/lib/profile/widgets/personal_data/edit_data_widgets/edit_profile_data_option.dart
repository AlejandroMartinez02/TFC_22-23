import 'package:flutter/material.dart';
import 'package:grun_mobileapp/profile/widgets/profile_data_container.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/widgets/create_route.dart';
import '../../../ui/profile_provider.dart';
import 'edit_personal_data_screen.dart';

class EditProfileData extends StatelessWidget {
  const EditProfileData({
    super.key,
    required this.size,
    required this.bodyLarge,
  });

  final Size size;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              CreateRoutes.slideFadeIn(
                  direccion: const Offset(1, 0),
                  screen: const EditPersonalDataScreen()));
          profileProvider.copyUser();
        },
        child: ProfileDataContainer(
          size: size,
          child: Text(
            Constants.editProfileData,
            style: bodyLarge,
          ),
        ));
  }
}
