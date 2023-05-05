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

import '../widgets/register_form.dart';

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
