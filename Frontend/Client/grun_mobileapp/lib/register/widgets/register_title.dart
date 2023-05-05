import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).primaryColor;
    return Text(
      Constants.registerTitle,
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          color: mainColor,
          fontFamily: 'Paralucent',
          fontWeight: FontWeight.bold),
    );
  }
}
