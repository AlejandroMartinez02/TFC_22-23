import 'package:flutter/material.dart';
import 'package:grun_mobileapp/exports/screens.dart';
import 'package:grun_mobileapp/utils/utils.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;
    return MaterialButton(
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: size.height * 0.03,
        ),
        onPressed: () => Navigator.push(
            context,
            CreateRoutes.SlideFadeIn(
                direccion: const Offset(-1, 0), screen: const DrawerScreen())));
  }
}
