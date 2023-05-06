// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:grun_mobileapp/exports/screens.dart';
import 'package:grun_mobileapp/register/widgets/register_widgets.dart';
import '../../utils/utils.dart';
import '../ui/register_form_provider.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.registerForm,
  });

  final RegisterFormProvider registerForm;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const padding = 0.01;
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: registerForm.firstKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * padding),
            RegisterTextBox(
              hintText: 'Juan Carlos',
              inputType: TextInputType.name,
              labelText: 'Nombre',
              onChanged: (value) => registerForm.name = value,
              validator: (value) =>
                  value!.isEmpty ? "¡Debes escribir tu nombre! :)" : null,
            ),
            SizedBox(height: size.height * padding),
            RegisterTextBox(
              hintText: 'Cardo Jiménez',
              inputType: TextInputType.name,
              labelText: 'Apellidos',
              onChanged: (value) => registerForm.lastName = value,
              validator: (value) =>
                  value!.isEmpty ? "¡Debes escribir tus apellidos! :)" : null,
            ),
            RegisterTextBox(
              onChanged: (value) => registerForm.address = value,
              inputType: TextInputType.streetAddress,
              hintText: 'Avinguna Rei Jaume I, 32',
              labelText: 'Dirección',
              validator: (value) => value!.isEmpty
                  ? "¡Debes escribir tu dirección de casa! :)"
                  : null,
            ),
            SizedBox(height: size.height * padding),
            RegisterTextBox(
              hintText: '695811734',
              inputType: TextInputType.phone,
              labelText: 'Teléfono móvil',
              onChanged: (value) => registerForm.phoneNumber = value,
              validator: (value) => Validations.phoneValidator(value),
            ),
            SizedBox(height: size.height * padding),
            RegisterTextBox(
                hintText: 'juancarloscardo@gmail.com',
                inputType: TextInputType.emailAddress,
                labelText: 'Correo electrónico',
                onChanged: (value) => registerForm.email = value,
                validator: (value) => Validations.emailValidator(value)),
            SizedBox(height: size.height * padding),
            RegisterPasswordBox(registerForm: registerForm),
            SizedBox(height: size.height * (padding + 0.04)),
            RegisterButton(
                isLoading: registerForm.isLoading,
                onPressed: () async {
                  final response = await registerForm.isValidForm();
                  _checkResponse(response, context);
                }),
            SizedBox(
              height: size.height * padding,
            ),
            const _LoginText()
          ],
        ),
      ),
    );
  }

  void _checkResponse(String? response, BuildContext context) {
    switch (response) {
      case null:
        Navigator.pushReplacement(
            context,
            CreateRoutes.slideFadeIn(
                direccion: const Offset(1, 0), screen: const MainScreen()));
        break;
      case '500':
        NotificationService.showSnackBar(Constants.serverFailedText);
        break;
      case '404':
        NotificationService.showSnackBar(Constants.registerFailedText);
        break;
    }
  }
}

class _LoginText extends StatelessWidget {
  const _LoginText();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainColor = Theme.of(context).primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Constants.registerLoginText,
            style: TextStyle(
              fontSize: size.width < 600 ? 18 : 22,
              color: mainColor,
            )),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: Constants.registerLoginLink,
                style: TextStyle(
                    fontSize: size.width < 600 ? 18 : 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushReplacement(
                      context,
                      CreateRoutes.slideFadeIn(
                          direccion: const Offset(0, -1),
                          screen: LoginScreen())))
          ]),
        )
      ],
    );
  }
}
