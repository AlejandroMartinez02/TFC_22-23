import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OrderCost extends StatelessWidget {
  final double price;
  const OrderCost({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AutoSizeText('Total: ${price.toStringAsFixed(2)}€',
        minFontSize: size.width < 600 ? 26 : 34,
        style: Theme.of(context).textTheme.bodyLarge);
  }
}
