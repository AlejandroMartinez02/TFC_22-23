import 'package:flutter/material.dart';
import 'package:grun_mobileapp/profile/widgets/widgets.dart';

import '../../../utils/constants.dart';

class MyPersonalDataScreen extends StatelessWidget {
  const MyPersonalDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: size.width < 600 ? 22 : 26);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: size.height * 0.1,
        title: Text(
          Constants.personalDataAppBar,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: size.width < 600 ? 22 : 26),
        ),
      ),
      body: Column(
        children: [
          EditProfileData(size: size, bodyLarge: bodyLarge),
          ChangePasswordOption(size: size, bodyLarge: bodyLarge)
        ],
      ),
    );
  }
}
