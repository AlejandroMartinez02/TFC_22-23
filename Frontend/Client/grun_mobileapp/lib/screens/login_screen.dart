import 'package:flutter/material.dart';
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
              _LoginForm(),
              const SizedBox(height: 50),
            ],
          )),
          const SizedBox(height: 50),
          const Text('Crear nueva cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
        ]),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: const [
        LoginTextBox(
            text: "",
            inputType: TextInputType.emailAddress,
            icon: Icons.email_outlined,
            hintText: "alejandro@gmail.com",
            labelText: "Correo electrónico"),
        SizedBox(height: 20),
        LoginTextBox(
          text: "",
          inputType: TextInputType.visiblePassword,
          icon: Icons.lock,
          hintText: "ContraseñaSegura1234_",
          labelText: "Contraseña",
          obscureText: true,
        )
      ],
    ));
  }
}
