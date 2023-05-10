import 'package:flutter/material.dart';
import 'package:grun_mobileapp/profile/data/network/response/order_line_dto.dart';

import '../../../utils/constants.dart';
import '../../data/network/response/order_dto.dart';
import 'order_state_cost.dart';
import 'orderline_text.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.index});

  final OrderDTO order;
  final int index;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.03, vertical: size.height * 0.01),
      width: size.width,
      height: size.height * 0.25,
      child: Padding(
        padding: EdgeInsets.all(size.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Pedido #$index",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: size.width < 600 ? 25 : 30)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Text(convertToDate(order.date.toLocal()),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: size.width < 600 ? 20 : 25,
                        color: Colors.grey)),
              ),
            ]),
            const Divider(thickness: 2, color: Colors.white),
            OrderLinesWidget(orderLines: order.orderLines),
            const Divider(thickness: 2, color: Colors.white),
            OrderStateCost(order: order)
          ],
        ),
      ),
    );
  }

  String convertToDate(DateTime date) {
    final minutes =
        date.minute.toString().length == 1 ? '0${date.minute}' : date.minute;
    return '${date.day}-${date.month}-${date.year}  ${date.hour}:$minutes';
  }
}
