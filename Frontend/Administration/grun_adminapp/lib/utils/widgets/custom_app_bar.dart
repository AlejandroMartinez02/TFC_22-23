import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(children: [
        Expanded(
            child: SizedBox(
          child: MoveWindow(),
        )),
        Row(
          children: [
            MinimizeWindowButton(),
            MaximizeWindowButton(),
            CloseWindowButton()
          ],
        )
      ]),
    );
  }
}
