import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../widgets/login_body.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  bool? isLogout;
  String? message = ' ';

  LoginScreen({super.key, this.isLogout, this.message});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoginBody(
        child: _loginFrom(size: size, isLogout: isLogout, message: message),
      ),
    );
  }
}

class _loginFrom extends StatelessWidget {
  const _loginFrom({
    super.key,
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
          SizedBox(height: size.height * 0.05),
          if (isLogout ?? false)
            Text(
              message!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.red,
                    fontSize: size.width < 600 ? 16 : 18,
                  ),
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
          height: size.height * 0.25,
        ));
  }
}
