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
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontSize: size.width < 600 ? 22 : 28),
      ),
    );
  }
}
