import 'package:flutter/material.dart';

class ProfileDataContainer extends StatelessWidget {
  const ProfileDataContainer(
      {super.key, required this.child, required this.size});

  final Widget child;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: size.height * 0.02),
        padding: EdgeInsets.only(left: size.width * 0.05),
        alignment: Alignment.centerLeft,
        height: size.height * 0.05,
        width: size.width,
        child: child);
  }
}
