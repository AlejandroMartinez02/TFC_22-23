import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  final String name;
  const ProductTitle({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          name,
          style: _textStyle(size),
        ));
  }

  TextStyle _textStyle(Size size) {
    return TextStyle(
        fontFamily: 'Paralucent',
        fontSize: size.width < 600 ? 26 : 35,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis);
  }
}
