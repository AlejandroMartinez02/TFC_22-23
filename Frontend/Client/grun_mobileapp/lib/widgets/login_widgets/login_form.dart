import 'package:flutter/material.dart';
import 'package:grun_mobileapp/screens/screens.dart';
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
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            LoginTextBox(
              icon: Icons.email_outlined,
              onChanged: (value) => loginForm.email = value,
              inputType: TextInputType.emailAddress,
              labelText: "Correo electrónico",
              validator: (value) => Validations.emailValidator(value),
            ),
            const SizedBox(height: 20),
            const _passwordBox(),
            const SizedBox(
              height: 40,
            ),
            LoginButton(
                onPressed: () async => {
                      FocusScope.of(context).unfocus(),
                      print(loginForm.isValidForm2()),
                      if (await loginForm.isValidForm() == null)
                        {
                          Navigator.pushReplacement(
                              context,
                              CreateRoutes.SlideFadeIn(
                                  direccion: const Offset(1, 0),
                                  screen: const HomeScreen()))
                        }
                      else
                        {
                          SnackBar(
                            content: Text(
                              "pruebaaaaaa",
                            ),
                          ),
                        }
                    })
          ],
        ));
  }
}

class _passwordBox extends StatefulWidget {
  const _passwordBox({super.key});

  @override
  State<_passwordBox> createState() => _PasswordBoxState();
}

class _PasswordBoxState extends State<_passwordBox> {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final mainColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;

    return Container(
        constraints:
            const BoxConstraints(minWidth: 250, maxWidth: 400, maxHeight: 70),
        width: size.width * 0.3,
        child: TextFormField(
          obscureText: loginForm.isHidden,
          enableSuggestions: false,
          autocorrect: false,
          cursorColor: mainColor,
          decoration: passwordDecoration(loginForm, mainColor),
          onChanged: (value) => loginForm.password = value,
          validator: (value) => Validations.passwordValidator(value),
        ));
  }

  InputDecoration passwordDecoration(
      LoginFormProvider registerForm, Color mainColor) {
    return InputDecoration(
      suffixIcon: IconButton(
        splashRadius: 15,
        constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40),
        padding: EdgeInsets.zero,
        icon: registerForm.isHidden
            ? Icon(
                color: mainColor,
                Icons.visibility_off_outlined,
              )
            : Icon(color: mainColor, Icons.visibility_outlined),
        onPressed: () =>
            setState(() => registerForm.isHidden = !registerForm.isHidden),
      ),
      prefixIcon: Icon(
        Icons.lock_outlined,
        color: mainColor,
      ),
      label: const Text(
        "Contraseña",
        style: TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
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
