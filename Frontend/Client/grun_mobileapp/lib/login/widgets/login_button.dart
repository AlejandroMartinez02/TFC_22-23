import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const LoginButton(
      {super.key, required this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: size.height * 0.3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      disabledColor: Colors.grey,
      onPressed: isLoading ? null : onPressed,
      child: Text(
        isLoading ? 'Espere' : "Iniciar sesión",
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
