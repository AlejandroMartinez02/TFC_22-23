import 'package:flutter/material.dart';

import 'order_cost.dart';
import 'pay_order_button.dart';

class OrderBottomNavigation extends StatelessWidget {
  const OrderBottomNavigation({super.key, required this.cost});

  final double cost;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OrderCost(price: cost),
          const PayButton(),
        ],
      ),
    );
  }
}
