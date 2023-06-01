import 'package:flutter/material.dart';
import 'package:grun_mobileapp/profile/data/network/response/order_dto.dart';

import '../../../../utils/constants.dart';

class CustomOrderBottomBar extends StatelessWidget {
  const CustomOrderBottomBar({super.key, required this.order});

  final OrderDTO order;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainColor = Theme.of(context).primaryColor;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
        color: mainColor,
        height: size.height * 0.1,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              order.state,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: size.width < 600 ? 28 : 32,
                  color: Constants.pickColor(order.state)),
            ),
            Text(
              '${Constants.total} ${order.totalCost}€',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: size.width < 600 ? 28 : 32),
            ),
          ],
        ));
  }
}
