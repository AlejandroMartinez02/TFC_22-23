import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grun_mobileapp/providers/login_form_provider.dart';
import '../widgets/login_widgets/login_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(
          child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 250),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text('Inicio de sesión',
                  style: Theme.of(context).textTheme.headlineLarge),
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: const LoginForm(),
              ),
              const SizedBox(height: 20),
            ],
          )),
          const SizedBox(height: 50),
          const Text('Crear nueva cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
        ]),
      )),
    );
  }
}
