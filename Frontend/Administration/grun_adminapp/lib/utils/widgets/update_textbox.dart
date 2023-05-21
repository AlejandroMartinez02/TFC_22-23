import 'package:flutter/material.dart';

class CustomFormTextBox extends StatelessWidget {
  final Function(String?) onChanged;
  final TextInputType inputType;
  final String initialValue;
  final String hintText;
  final String labelText;
  final int maxLines;
  final String? Function(String?) validator;

  const CustomFormTextBox({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.inputType,
    required this.hintText,
    required this.labelText,
    required this.validator,
    required this.maxLines,
  });

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
        maxLines: maxLines,
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType: inputType,
        validator: validator,
        decoration: textboxDecoration(mainColor, hintText),
      ),
    );
  }

  InputDecoration textboxDecoration(Color mainColor, String hintText) {
    return InputDecoration(
      label: Text(
        labelText,
        style: const TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
      ),
      hintText: hintText,
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
