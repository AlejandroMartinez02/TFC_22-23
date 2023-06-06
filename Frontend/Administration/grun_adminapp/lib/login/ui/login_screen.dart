// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/custom_app_bar.dart';
import '../widgets/login_widgets.dart';

class LoginScreen extends StatelessWidget {
  bool? isLogout;
  String? message = ' ';

  LoginScreen({super.key, this.isLogout, this.message});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: LoginBody(
        child: _LoginForm(size: size, isLogout: isLogout, message: message),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Platform.isLinux || Platform.isIOS || Platform.isWindows
              ? const CustomAppBar()
              : Container(),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal:
                    size.width < 500 ? size.width * 0.01 : size.width * 0.1),
            child: Column(children: [
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
            ]),
          )
        ],
      ),
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
          height: size.height * 0.27,
        ));
  }
}
