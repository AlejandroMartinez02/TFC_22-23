import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/widgets/create_route.dart';
import '../../ui/profile_provider.dart';
import '../profile_data_container.dart';
import 'edit_data_widgets/edit_personal_data_screen.dart';

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
      child: Container(
        margin:
            EdgeInsets.only(left: size.width * 0.02, top: size.height * 0.02),
        width: size.width,
        child: ProfileDataContainer(
          size: size,
          child: Text(
            Constants.editProfileData,
            style: bodyLarge,
          ),
        ),
      ),
    );
  }
}
