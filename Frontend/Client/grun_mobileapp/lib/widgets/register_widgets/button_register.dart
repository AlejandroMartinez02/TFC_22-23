import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: size.height * 0.2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      onPressed: onPressed,
      child: Text(
        "Registarme",
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
