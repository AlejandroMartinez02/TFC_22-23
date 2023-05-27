import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../ui/graphics_provider.dart';

class LastOrdersButtons extends StatelessWidget {
  const LastOrdersButtons({
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
            color: graphicsProvider.currentNumOrders.abs() == 10
                ? Constants.secondaryColor
                : null,
            onPressed: () async {
              graphicsProvider.changeCurrentNumOrders(10);
            },
            child: Text('Últimos 10 pedidos',
                style: bodyLarge.copyWith(
                    color: graphicsProvider.currentNumOrders.abs() == 10
                        ? Colors.white
                        : Colors.black))),
        MaterialButton(
            color: graphicsProvider.currentNumOrders.abs() == 50
                ? Constants.secondaryColor
                : null,
            onPressed: () async {
              graphicsProvider.changeCurrentNumOrders(50);
            },
            child: Text('Últimos 50 pedidos',
                style: bodyLarge.copyWith(
                    color: graphicsProvider.currentNumOrders.abs() == 50
                        ? Colors.white
                        : Colors.black))),
        MaterialButton(
          color: graphicsProvider.currentNumOrders.abs() == 100
              ? Constants.secondaryColor
              : null,
          onPressed: () async {
            graphicsProvider.changeCurrentNumOrders(100);
          },
          child: Text('Últimos 100 pedidos',
              style: bodyLarge.copyWith(
                  color: graphicsProvider.currentNumOrders.abs() == 100
                      ? Colors.white
                      : Colors.black)),
        )
      ],
    );
  }
}
