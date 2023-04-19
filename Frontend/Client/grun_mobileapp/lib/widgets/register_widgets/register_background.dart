import 'package:flutter/material.dart';
import 'package:grun_mobileapp/utils/utils.dart' show AnimatedWave;

class RegisterBackground extends StatelessWidget {
  const RegisterBackground({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedWave(
        height: height * 0.2,
        speed: 0.2,
      ),
    );
  }
}
