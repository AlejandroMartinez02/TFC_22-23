// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/widgets/drawer_widgets/drawer_widgets.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final List<Widget> widgets = [
    const Align(
      alignment: Alignment.bottomCenter,
      child: LogOut(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column());
  }
}
