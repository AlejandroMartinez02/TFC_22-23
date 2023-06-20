import 'package:flutter/material.dart';

import '../../utils/validators.dart';
import '../ui/register_form_provider.dart';

class RegisterPasswordBox extends StatelessWidget {
  final RegisterFormProvider registerForm;
  const RegisterPasswordBox({super.key, required this.registerForm});
  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;

    return Container(
        constraints: const BoxConstraints(minWidth: 250, maxWidth: 400),
        width: size.width < 600 ? size.width * 0.3 : size.width * 0.5,
        child: TextFormField(
          style:
              Theme.of(context).textTheme.bodyLarge!.copyWith(color: mainColor),
          obscureText: registerForm.isHidden,
          enableSuggestions: false,
          autocorrect: false,
          cursorColor: mainColor,
          decoration: passwordDecoration(registerForm, mainColor),
          onChanged: (value) => registerForm.password = value,
          validator: (value) => Validations.passwordValidator(value),
        ));
  }

  InputDecoration passwordDecoration(
      RegisterFormProvider registerForm, Color mainColor) {
    return InputDecoration(
      suffixIcon: IconButton(
        splashRadius: 15,
        padding: EdgeInsets.zero,
        icon: registerForm.isHidden
            ? Icon(
                color: mainColor,
                Icons.visibility,
              )
            : Icon(color: mainColor, Icons.visibility_off),
        onPressed: () => registerForm.isHidden = !registerForm.isHidden,
      ),
      label: const Text(
        "Contraseña",
        style: TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
      ),
      hintText: "********",
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
