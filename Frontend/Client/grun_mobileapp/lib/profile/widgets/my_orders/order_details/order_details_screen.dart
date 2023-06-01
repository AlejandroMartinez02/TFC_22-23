import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../data/network/response/order_dto.dart';
import 'custom_order_bottombar.dart';
import 'order_line_details.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderDTO order;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainColor = Theme.of(context).primaryColor;
    return Scaffold(
        bottomNavigationBar: CustomOrderBottomBar(order: order),
        appBar: AppBar(
          title: Text(
            Constants.orderSummary,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: size.width < 600 ? 26 : 30),
          ),
          backgroundColor: mainColor,
          toolbarHeight: size.height * 0.1,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: mainColor,
            padding: EdgeInsets.only(top: size.height * 0.01),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...order.orderLines
                    .map((line) => OrderLineDetails(orderLine: line))
              ],
            ),
          ),
        ));
  }
}
