import 'package:flutter/material.dart';

class LoginTextBox extends StatelessWidget {
  final Function(String?) onChanged;
  final TextInputType inputType;
  final IconData icon;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final String? Function(String?) validator;

  const LoginTextBox({
    super.key,
    required this.onChanged,
    required this.inputType,
    required this.icon,
    required this.hintText,
    required this.labelText,
    this.obscureText = false,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainColor = Theme.of(context).primaryColor;
    return Container(
      constraints: BoxConstraints(minWidth: 250, maxWidth: 400),
      width: size.width * 0.3,
      child: TextFormField(
        cursorColor: mainColor,
        autofocus: false,
        initialValue: '',
        onChanged: onChanged,
        keyboardType: inputType,
        obscureText: obscureText,
        validator: validator,
        decoration: textboxDecoration(mainColor),
      ),
    );
  }

  InputDecoration textboxDecoration(Color mainColor) {
    return InputDecoration(
        label: Text(
          labelText,
          style: const TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
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
        ));
  }
}
