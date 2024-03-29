import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/register_form.dart';
import '../widgets/register_widgets.dart';
import 'register_form_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: RegisterBody(
          height: size.height,
          child: _WholeRegisterForm(size: size, registerForm: registerForm)),
    );
  }
}

class _WholeRegisterForm extends StatelessWidget {
  const _WholeRegisterForm({
    required this.size,
    required this.registerForm,
  });

  final Size size;
  final RegisterFormProvider registerForm;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05,
            horizontal:
                size.width < 600 ? size.width * 0.01 : size.width * 0.1),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const RegisterHeaderIcon(),
          const RegisterTitle(),
          RegisterForm(registerForm: registerForm)
        ]));
  }
}
