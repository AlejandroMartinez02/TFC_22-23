import 'package:flutter/material.dart';

class CreateRoutes {
  static Route SlideFadeIn(
      {required Offset direccion, required Widget screen}) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          screen,
      transitionDuration: Duration(milliseconds: 1500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curveAnimation =
            CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn);
        return SlideTransition(
            position: Tween<Offset>(begin: direccion, end: Offset.zero)
                .animate(curveAnimation),
            child: FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(curveAnimation),
              child: child,
            ));
      },
    );
  }
}

//easeInOutCubic
