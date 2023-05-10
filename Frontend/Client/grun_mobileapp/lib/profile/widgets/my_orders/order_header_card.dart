import 'package:flutter/material.dart';

import '../../data/network/response/order_dto.dart';
import 'order_date.dart';
import 'order_title.dart';

class OrderHeaderCard extends StatelessWidget {
  const OrderHeaderCard({
    super.key,
    required this.index,
    required this.size,
    required this.order,
  });

  final int index;
  final Size size;
  final OrderDTO order;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      OrderTitle(index: index, size: size),
      OrderDate(date: order.date),
    ]);
  }
}
