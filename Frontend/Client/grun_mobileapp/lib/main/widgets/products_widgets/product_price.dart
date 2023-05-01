import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final double price;
  const ProductPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(
      '$price€',
      style: TextStyle(
          fontFamily: 'Paralucent',
          fontSize: size.width < 600 ? 30 : 35,
          fontWeight: FontWeight.bold),
    );
  }
}
