// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/main/widgets/drawer_widgets/drawer_widgets.dart';
import 'package:animate_do/animate_do.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: primaryColor,
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: FadeInRight(
              duration: const Duration(milliseconds: 500),
              child: const LogOut(),
            ),
          ),
        ]));
  }
}
