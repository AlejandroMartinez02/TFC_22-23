import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: size.height * 0.3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      onPressed: onPressed,
      child: Text(
        "Iniciar sesión",
        style: _buttonTextStyle(),
      ),
    );
  }

  TextStyle _buttonTextStyle() => const TextStyle(
        fontFamily: "Calibri",
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );
}
