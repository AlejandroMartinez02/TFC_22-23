import 'package:flutter/material.dart';
import 'package:grun_mobileapp/utils/constants.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Text(
        Constants.mainTitle,
        style: _textStyle(size.width),
      ),
    );
  }

  TextStyle _textStyle(double width) => TextStyle(
      fontSize: width < 600 ? 30 : 36,
      fontWeight: FontWeight.bold,
      fontFamily: 'Paralucent');
}
