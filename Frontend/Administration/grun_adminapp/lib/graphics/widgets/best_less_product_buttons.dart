import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../ui/graphics_provider.dart';

class BestLessProductButtons extends StatelessWidget {
  const BestLessProductButtons({
    super.key,
    required this.graphicsProvider,
    required this.bodyLarge,
  });

  final GraphicsProvider graphicsProvider;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
            color: graphicsProvider.isBestSelected
                ? Constants.secondaryColor
                : null,
            onPressed: () {
              graphicsProvider.changeIsBestSelected(true);
            },
            child: Text('Productos más vendidos',
                style: bodyLarge.copyWith(
                    color: graphicsProvider.isBestSelected
                        ? Colors.white
                        : Colors.black))),
        MaterialButton(
            color: !graphicsProvider.isBestSelected
                ? Constants.secondaryColor
                : null,
            onPressed: () {
              graphicsProvider.changeIsBestSelected(false);
            },
            child: Text('Productos menos vendidos',
                style: bodyLarge.copyWith(
                    color: !graphicsProvider.isBestSelected
                        ? Colors.white
                        : Colors.black))),
      ],
    );
  }
}
