import 'package:flutter/material.dart';
import 'package:grun_mobileapp/exports/providers.dart';
import 'package:provider/provider.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const RegisterButton(
      {super.key, required this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: size.height * 0.2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textColor: Colors.white,
      disabledColor: Colors.grey,
      color: Theme.of(context).primaryColor,
      onPressed: isLoading ? null : onPressed,
      child: Text(
        isLoading ? 'Espere' : 'Registrarme',
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
