import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grun_mobileapp/exports/providers.dart';
import 'package:grun_mobileapp/login/widgets/login_widgets.dart'
    show LoginBody, LoginForm;
import 'package:grun_mobileapp/register/ui/register_screen.dart';
import 'package:grun_mobileapp/utils/create_route.dart';
import 'package:grun_mobileapp/utils/utils.dart' show Constants;

class LoginScreen extends StatelessWidget {
  bool? isLogout;
  String? message = ' ';

  LoginScreen({super.key, this.isLogout, this.message});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginBody(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal:
                  size.width < 500 ? size.width * 0.01 : size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _HeaderIcon(),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(Constants.loginTitle,
                  style: Theme.of(context).textTheme.headlineLarge),
              SizedBox(
                height: size.height * 0.04,
              ),
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: const LoginForm(),
              ),
              SizedBox(height: size.height * 0.04),
              const _RegisterText(),
              SizedBox(height: size.height * 0.05),
              if (isLogout ?? false)
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: size.width < 600 ? 16 : 18,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterText extends StatelessWidget {
  const _RegisterText();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(Constants.loginRegisterText,
            style: TextStyle(
              fontSize: 18,
            )),
        RichText(
          text: TextSpan(
              text: Constants.loginRegisterLink,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pushReplacement(
                    context,
                    CreateRoutes.SlideFadeIn(
                        direccion: const Offset(0, 1),
                        screen: const RegisterScreen()))),
        ),
      ],
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: size.height * 0.1),
        child: Image(
          image: const AssetImage(
            Constants.lightLogoApp,
          ),
          height: size.height * 0.25,
        ));
  }
}
