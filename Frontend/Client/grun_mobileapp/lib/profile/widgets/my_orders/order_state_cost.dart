import 'package:flutter/material.dart';

import '../../data/network/response/order_dto.dart';

class OrderStateCost extends StatelessWidget {
  const OrderStateCost({super.key, required this.order});

  final OrderDTO order;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: Container(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.state,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: size.width < 600 ? 20 : 25,
                    color: _pickColor(order.state)),
              ),
              Text(
                'Total: ${order.totalCost}€',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: size.width < 600 ? 20 : 25),
              ),
            ],
          )),
    );
  }

  Color _pickColor(String state) {
    Color color;
    switch (state) {
      case 'En proceso':
        color = Colors.green;
        break;
      case 'Finalizado':
        color = Colors.red;
        break;
      case 'Entregando':
        color = Colors.white;
        break;
      default:
        color = Colors.orange;
    }

    return color;
  }
}
