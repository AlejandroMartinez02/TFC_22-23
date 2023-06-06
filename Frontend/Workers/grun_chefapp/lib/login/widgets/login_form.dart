import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

import '../../orders/ui/orders_screen.dart';
import 'login_widgets.dart';
import '../ui/login_form_provider.dart';
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
            RawKeyboardListener(
              focusNode: FocusNode(),
              child: const _passwordBox(),
              onKey: (RawKeyEvent event) async {
                if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                  checkUser(context, loginForm);
                }
              },
            ),
            const SizedBox(
              height: 40,
            ),
            LoginButton(
                isLoading: loginForm.isLoading,
                onPressed: () async {
                  checkUser(context, loginForm);
                })
          ],
        ));
  }
}

void checkUser(BuildContext context, LoginFormProvider loginForm) async {
  FocusScope.of(context).unfocus();

  final responseLogin = await loginForm.isValidForm();
  SchedulerBinding.instance.addPostFrameCallback((_) {
    _checkResponse(responseLogin, context);
  });
}

void _checkResponse(String? responseLogin, BuildContext context) {
  switch (responseLogin) {
    case null:
      Navigator.pushReplacement(
          context,
          CreateRoutes.slideFadeIn(
              direccion: const Offset(1, 0), screen: const OrdersScreen()));

      break;
    case '401':
      NotificationService.showSnackBar(Constants.wrongLogin);
      break;
    case '403':
      NotificationService.showSnackBar(Constants.accountLocked);
      break;
    case '404':
      NotificationService.showSnackBar('NO SE QUE PASA');
      break;
    case Constants.error:
      NotificationService.showSnackBar(Constants.errorPageText);
  }
}

// ignore: camel_case_types
class _passwordBox extends StatelessWidget {
  const _passwordBox();
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final mainColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;

    return Container(
      constraints:
          const BoxConstraints(minWidth: 250, maxWidth: 400, maxHeight: 70),
      width: size.width < 600 ? size.width * 0.3 : size.width * 0.5,
      child: TextFormField(
          obscureText: loginForm.isHidden,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.black),
          enableSuggestions: false,
          autocorrect: false,
          cursorColor: mainColor,
          decoration: passwordDecoration(loginForm, mainColor),
          onChanged: (value) => loginForm.password = value,
          validator: (value) => value!.isEmpty ? Constants.passwordError : null,
          onFieldSubmitted: (_) async {
            FocusScope.of(context).unfocus();
            final responseLogin = await loginForm.isValidForm();
            SchedulerBinding.instance.addPostFrameCallback((_) {
              _checkResponse(responseLogin, context);
            });
          }),
    );
  }

  InputDecoration passwordDecoration(
      LoginFormProvider loginForm, Color mainColor) {
    return InputDecoration(
      suffixIcon: IconButton(
        splashRadius: 15,
        constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40),
        padding: EdgeInsets.zero,
        icon: loginForm.isHidden
            ? Icon(
                color: mainColor,
                Icons.visibility_off_outlined,
              )
            : Icon(color: mainColor, Icons.visibility_outlined),
        onPressed: () => loginForm.isHidden = !loginForm.isHidden,
      ),
      prefixIcon: Icon(
        Icons.lock_outlined,
        color: mainColor,
      ),
      label: const Text(
        Constants.labelPassword,
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
