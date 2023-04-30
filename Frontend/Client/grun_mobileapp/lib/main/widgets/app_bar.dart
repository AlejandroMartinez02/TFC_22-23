import 'package:flutter/material.dart';
import 'package:grun_mobileapp/main/widgets/drawer_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        color: primaryColor,
      ),
      child: Row(
        children: [DrawerButton()],
      ),
    );
  }
}
