import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "¡Lo más vendido!",
      style: _textStyle(),
    );
  }

  TextStyle _textStyle() =>
      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
}
