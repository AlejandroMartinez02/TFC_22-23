// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/exports/providers.dart';
import 'package:grun_mobileapp/exports/screens.dart' show LoginScreen;
import 'package:grun_mobileapp/utils/utils.dart' show CreateRoutes;
import 'package:provider/provider.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                size: 40,
                Icons.logout_outlined,
                color: Colors.white,
              ),
              const SizedBox(
                width: 20,
              ),
              RichText(
                  text: const TextSpan(children: [
                TextSpan(text: "Cerrar sesión", style: TextStyle(fontSize: 22))
              ])),
            ]),
        onTap: () async {
          final loginForm =
              Provider.of<LoginFormProvider>(context, listen: false);
          //await loginForm.logout();
          Navigator.pushReplacement(
              context,
              CreateRoutes.SlideFadeIn(
                  direccion: const Offset(-1, 0), screen: LoginScreen()));
        },
      ),
    );
  }
}
