import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/widgets/create_route.dart';
import 'change_password_widgets/change_password_screen.dart';
import '../profile_data_container.dart';

class ChangePasswordOption extends StatelessWidget {
  const ChangePasswordOption({
    super.key,
    required this.size,
    required this.bodyLarge,
  });

  final Size size;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CreateRoutes.slideFadeIn(
                direccion: const Offset(1, 0),
                screen: const ChangePasswordScreen()));
      },
      child: Container(
        margin:
            EdgeInsets.only(left: size.width * 0.02, top: size.height * 0.02),
        child: ProfileDataContainer(
          size: size,
          child: Text(
            Constants.editPassword,
            style: bodyLarge,
          ),
        ),
      ),
    );
  }
}
