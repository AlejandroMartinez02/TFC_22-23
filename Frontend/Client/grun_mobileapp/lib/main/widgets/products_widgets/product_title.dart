import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class ProductTitle extends StatelessWidget {
  final String name;
  const ProductTitle({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width < 600 ? 24.0 : 26.0;
    return AutoSizeText(name,
        maxLines: 1,
        minFontSize: size.width < 600 ? 26 : 35,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: fontSize,
            ),
        overflowReplacement: Marquee(
          crossAxisAlignment: CrossAxisAlignment.end,
          pauseAfterRound: const Duration(seconds: 2),
          startPadding: 18.0,
          blankSpace: 22,
          accelerationDuration: const Duration(seconds: 1),
          accelerationCurve: Curves.easeInCubic,
          decelerationDuration: const Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOutCubic,
          text: name,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: fontSize,
              ),
        ));
  }
}
