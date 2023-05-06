import 'package:flutter/material.dart';

import '../../utils/widgets/animated_background.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedWave(height: size.height * 0.8, speed: 0.20),
          ),
          child,
        ],
      ),
    );
  }
}
