import 'package:flutter/material.dart';

class UpdateTextBox extends StatelessWidget {
  const UpdateTextBox({
    super.key,
    required this.onChanged,
    required this.inputType,
    required this.labelText,
    required this.validator,
    required this.initialValue,
  });

  final Function(String?) onChanged;
  final TextInputType inputType;
  final String labelText;
  final String initialValue;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainColor = Theme.of(context).primaryColor;
    return Container(
      constraints: const BoxConstraints(minWidth: 250, maxWidth: 400),
      width: size.width < 600 ? size.width * 0.3 : size.width * 0.5,
      child: TextFormField(
        style:
            Theme.of(context).textTheme.bodyLarge!.copyWith(color: mainColor),
        cursorColor: mainColor,
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType: inputType,
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
    );
  }
}
