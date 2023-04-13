import 'package:flutter/material.dart';

class LoginTextBox extends StatelessWidget {
  final String text;
  final TextInputType inputType;
  final IconData icon;
  final String hintText;
  final String labelText;
  final bool obscureText;

  const LoginTextBox(
      {super.key,
      required this.text,
      required this.inputType,
      required this.icon,
      required this.hintText,
      required this.labelText,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).primaryColor;
    return TextFormField(
      autofocus: false,
      initialValue: '',
      keyboardType: inputType,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          label: Text(
            labelText,
            style: const TextStyle(color: Colors.grey),
          ),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: mainColor,
            width: 2,
          )),
          prefixIcon: Icon(
            icon,
            color: mainColor,
          )),
    );
  }
}
