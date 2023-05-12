import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../utils/constants.dart';
import '../../utils/widgets/create_route.dart';
import 'personal_data/personal_data_screen.dart';

class PersonalDataButton extends StatelessWidget {
  const PersonalDataButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            CreateRoutes.slideFadeIn(
                direccion: const Offset(1, 0),
                screen: const MyPersonalDataScreen()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
        margin:
            EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.02),
        width: size.width,
        child: Text(Constants.personalDataText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: size.width < 600 ? 22 : 26, color: Colors.black)),
      ),
    );
  }
}
