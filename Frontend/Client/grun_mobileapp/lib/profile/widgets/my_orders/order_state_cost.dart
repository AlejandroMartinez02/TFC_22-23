import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
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
                    color: Constants.pickColor(order.state)),
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
}
