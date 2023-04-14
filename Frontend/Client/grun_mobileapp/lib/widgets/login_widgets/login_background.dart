import 'package:flutter/material.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          _GreenBox(),
          _HeaderIcon(),
          child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 30),
          child: Image.asset(
            "assets/1.png",
            height: 50,
            width: 50,
          )),
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