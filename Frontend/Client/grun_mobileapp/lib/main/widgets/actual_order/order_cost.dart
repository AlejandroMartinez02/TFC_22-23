import 'package:flutter/material.dart';

class OrderCost extends StatelessWidget {
  final double price;
  const OrderCost({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(
      'Total: ${price.toStringAsFixed(2)}€',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: size.width < 600 ? 30 : 34,
          ),
    );
  }
}
