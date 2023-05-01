import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final String description;
  const ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(description,
        textAlign: TextAlign.justify,
        style: TextStyle(
            color: Colors.grey,
            fontSize: size.width < 600 ? 22 : 28,
            fontFamily: 'Paralucent'));
  }
}
