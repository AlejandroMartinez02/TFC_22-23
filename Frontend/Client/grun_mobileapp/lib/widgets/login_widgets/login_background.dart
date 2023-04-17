import 'package:flutter/material.dart';

import 'login_widgets.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          AnimatedWave(
            height: size.height,
            speed: 0.25,
            direction: 0.6,
          ),
          child,
        ],
      ),
    );
  }
}

class _GreenBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _greenBackground(),
    );
  }

  BoxDecoration _greenBackground() {
    return const BoxDecoration(
        gradient: LinearGradient(colors: [
      Color.fromRGBO(40, 182, 116, 1),
      Color.fromRGBO(40, 182, 100, 0.3)
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter));
  }
}

//TODO: Implement this Widget with animation
//* These are widgets that maybe i'll use in the future
// class _BubbleForm extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 100,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(100),
//         color: const Color.fromRGBO(255, 255, 255, 0.22)
//       ),
//     );
//   }
// }

// class _LoginMainBox extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Positioned(
//       top: size.height * 0.1,
//       left: size.width * 0.1,
//       child: _MainBox(),
//     );
//   }
// }

// class _MainBox extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.4,
//       width: size.width * 0.8,
//       decoration: BoxDecoration(
//         color: Colors.red,
//         border: const Border.symmetric(),
//         borderRadius: BorderRadius.circular(15),
//       ),
//     );
//   }
// }