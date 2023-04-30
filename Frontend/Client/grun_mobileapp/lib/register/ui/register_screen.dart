// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grun_mobileapp/exports/providers.dart';
import 'package:grun_mobileapp/exports/screens.dart';
import 'package:grun_mobileapp/utils/services/notification_service.dart';
import 'package:grun_mobileapp/utils/constants.dart';
import 'package:grun_mobileapp/register/widgets/register_passwordbox.dart';
import 'package:grun_mobileapp/register/widgets/register_widgets.dart';
import 'package:provider/provider.dart';
import 'package:grun_mobileapp/utils/utils.dart' show CreateRoutes, Validations;

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        RegisterBackground(height: size.height),
        ChangeNotifierProvider(
          create: (_) => RegisterFormProvider(),
          child: _RegisterForm(registerForm: registerForm),
        )
      ]),
    );
  }
}

class _RegisterTitle extends StatelessWidget {
  const _RegisterTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      Constants.registerTitle,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({
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
            const _HeaderIcon(),
            const _RegisterTitle(),
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
            PasswordBox(registerForm: registerForm),
            SizedBox(height: size.height * (padding + 0.04)),
            RegisterButton(
                isLoading: registerForm.isLoading,
                onPressed: () async {
                  if (await registerForm.isValidForm() == null) {
                    Navigator.pushReplacement(
                        context,
                        CreateRoutes.SlideFadeIn(
                            direccion: const Offset(1, 0),
                            screen: const HomeScreen()));
                  } else {
                    NotificationService.showSnackBar(
                        "El correo electrónico ya está en uso, por favor ingresa uno nuevo");
                  }
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
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height < 800 ? size.height * 0.15 : size.height * 0.25,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const Image(
          image: AssetImage("assets/dark_logo.png"),
        ));
  }
}

class _LoginText extends StatelessWidget {
  const _LoginText();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Constants.registerLoginText,
            style: TextStyle(
              fontSize: size.width < 600 ? 18 : 22,
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
                      CreateRoutes.SlideFadeIn(
                          direccion: const Offset(0, -1),
                          screen: LoginScreen())))
          ]),
        )
      ],
    );
  }
}
