import 'package:flutter/material.dart';

import '../../utils/widgets/animated_background.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key, required this.height, required this.child});
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedWave(
            height: height * 0.2,
            speed: 0.2,
          ),
        ),
        child
      ]),
    );
  }
}
