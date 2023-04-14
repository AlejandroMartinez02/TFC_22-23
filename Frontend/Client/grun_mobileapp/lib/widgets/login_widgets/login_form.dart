import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_widgets.dart';
import '../../providers/login_form_provider.dart';
import '../../utils/utils.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            LoginTextBox(
              onChanged: (value) => loginForm.email = value,
              inputType: TextInputType.emailAddress,
              icon: Icons.email_outlined,
              hintText: "ejemplo_correo10@gmail.com",
              labelText: "Correo electrónico",
              validator: (value) => Validations.emailValidator(value),
            ),
            const SizedBox(height: 20),
            LoginTextBox(
              onChanged: (value) => loginForm.password = value,
              inputType: TextInputType.visiblePassword,
              icon: Icons.lock,
              hintText: "*******",
              labelText: "Contraseña",
              obscureText: true,
              validator: (value) => Validations.passwordValidator(value),
            ),
            const SizedBox(
              height: 40,
            ),
            LoginButton(onPressed: () => {})
          ],
        ));
  }
}
