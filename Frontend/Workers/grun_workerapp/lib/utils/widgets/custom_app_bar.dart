import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Container(
        color: Colors.white,
        child: Row(children: [
          Expanded(
              child: SizedBox(
            child: MoveWindow(),
          )),
          Row(
            children: [
              MinimizeWindowButton(
                colors: WindowButtonColors(iconNormal: Colors.black),
              ),
              MaximizeWindowButton(
                  colors: WindowButtonColors(iconNormal: Colors.black)),
              CloseWindowButton(
                  colors: WindowButtonColors(iconNormal: Colors.black))
            ],
          )
        ]),
      ),
    );
  }
}
