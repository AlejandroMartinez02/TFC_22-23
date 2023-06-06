import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const RegisterButton(
      {super.key, required this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: size.height * 0.2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      textColor: Colors.white,
      disabledColor: Colors.grey,
      color: mainColor,
      onPressed: isLoading ? null : onPressed,
      child: Text(
        isLoading ? 'Espere' : 'Registrarme',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
