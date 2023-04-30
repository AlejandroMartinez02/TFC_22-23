import 'package:flutter/material.dart';
import 'package:grun_mobileapp/utils/constants.dart';

class BackgroundColor extends StatelessWidget {
  const BackgroundColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(139, 139, 139, 0.6),
                Color.fromRGBO(112, 112, 112, 0.6),
              ])),
    );
  }
}
