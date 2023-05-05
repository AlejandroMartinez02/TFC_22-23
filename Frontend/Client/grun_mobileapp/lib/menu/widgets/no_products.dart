import 'package:flutter/material.dart';

class NoProducts extends StatelessWidget {
  const NoProducts({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.3),
      child: Text(
        "No hay ningún producto",
        style: TextStyle(
            color: Colors.black,
            fontSize: size.width < 600 ? 24 : 30,
            fontFamily: 'Paralucent',
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
