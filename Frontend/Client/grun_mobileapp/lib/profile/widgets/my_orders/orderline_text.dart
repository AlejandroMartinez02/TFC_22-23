import 'package:flutter/material.dart';

import '../../data/network/response/order_line_dto.dart';

// ignore: must_be_immutable
class OrderLinesWidget extends StatelessWidget {
  OrderLinesWidget({super.key, required this.orderLines});

  List<OrderLineDTO> orderLines;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontSize: size.width < 600 ? 16 : 18);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: orderLines.length < 3 ? orderLines.length : 3,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${orderLines[index].product.name} x ${orderLines[index].count}',
                  style: bodyLarge,
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  '${orderLines[index].cost}€',
                  style: bodyLarge,
                ),
              ],
            );
          },
        ),
        if (orderLines.length > 3)
          Text(
            '...',
            style: bodyLarge.copyWith(fontSize: size.width < 600 ? 20 : 22),
          )
      ],
    );
  }
}
