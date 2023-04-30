import 'package:flutter/material.dart';

class LoginTextBox extends StatelessWidget {
  final Function(String?) onChanged;
  final TextInputType inputType;
  final String labelText;
  final IconData icon;
  final String? Function(String?) validator;

  const LoginTextBox({
    super.key,
    required this.onChanged,
    required this.icon,
    required this.inputType,
    required this.labelText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainColor = Theme.of(context).primaryColor;
    return Container(
      constraints: const BoxConstraints(minWidth: 250, maxWidth: 400),
      width: size.width < 600 ? size.width * 0.3 : size.width * 0.5,
      child: TextFormField(
        cursorColor: mainColor,
        initialValue: '',
        onChanged: onChanged,
        keyboardType: inputType,
        validator: validator,
        decoration: textboxDecoration(mainColor, icon),
      ),
    );
  }

  InputDecoration textboxDecoration(Color mainColor, IconData icon) {
    return InputDecoration(
      label: Text(
        labelText,
        style: const TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
      ),
      prefixIcon: Icon(icon, color: mainColor),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: mainColor,
        width: 2,
      )),
    );
  }
}
