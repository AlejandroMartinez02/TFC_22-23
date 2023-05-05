import 'package:flutter/material.dart';

class RegisterHeaderIcon extends StatelessWidget {
  const RegisterHeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height < 800 ? size.height * 0.15 : size.height * 0.25,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const Image(
          image: AssetImage("assets/dark_logo.png"),
        ));
  }
}
