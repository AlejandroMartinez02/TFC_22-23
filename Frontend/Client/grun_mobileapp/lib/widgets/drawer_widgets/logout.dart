// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grun_mobileapp/providers/providers.dart';
import 'package:grun_mobileapp/screens/screens.dart' show LoginScreen;
import 'package:grun_mobileapp/utils/utils.dart' show CreateRoutes;
import 'package:provider/provider.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.logout_outlined,
            color: Colors.red[400],
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Cerrar sesión",
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final loginForm =
                        Provider.of<LoginFormProvider>(context, listen: false);
                    await loginForm.logout();
                    Navigator.pushReplacement(
                        context,
                        CreateRoutes.SlideFadeIn(
                            direccion: const Offset(-1, 0),
                            screen: const LoginScreen()));
                  })
          ])),
        ]);
  }
}
