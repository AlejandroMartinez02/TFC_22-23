import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grun_mobileapp/exports/providers.dart';
import 'package:grun_mobileapp/login/widgets/login_widgets.dart'
    show LoginBody, LoginForm;
import 'package:grun_mobileapp/register/ui/register_screen.dart';
import 'package:grun_mobileapp/utils/utils.dart' show Constants, CreateRoutes;

class LoginScreen extends StatelessWidget {
  bool? isLogout;
  String? message = ' ';

  LoginScreen({super.key, this.isLogout, this.message});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginBody(
        child: _loginForm(size: size, isLogout: isLogout, message: message),
      ),
    );
  }
}

class _loginForm extends StatelessWidget {
  const _loginForm({
    required this.size,
    required this.isLogout,
    required this.message,
  });

  final Size size;
  final bool? isLogout;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
          horizontal: size.width < 500 ? size.width * 0.01 : size.width * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _HeaderIcon(),
          SizedBox(
            height: size.height * 0.04,
          ),
          Text(Constants.loginTitle,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.black,
                  )),
          SizedBox(
            height: size.height * 0.04,
          ),
          const LoginForm(),
          SizedBox(height: size.height * 0.04),
          const _RegisterText(),
          SizedBox(height: size.height * 0.05),
          if (isLogout ?? false)
            Text(
              message!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.red,
                    fontSize: size.width < 600 ? 16 : 18,
                  ),
            )
        ],
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
        Text(Constants.loginRegisterText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                )),
        RichText(
          text: TextSpan(
              text: Constants.loginRegisterLink,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pushReplacement(
                    context,
                    CreateRoutes.slideFadeIn(
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
