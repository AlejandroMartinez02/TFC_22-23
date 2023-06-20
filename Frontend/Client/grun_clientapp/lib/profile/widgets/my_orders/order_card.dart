import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/widgets/create_route.dart';
import '../../data/network/response/order_dto.dart';
import 'order_details/order_details_screen.dart';
import 'order_header_card.dart';
import 'order_state_cost.dart';
import 'orderline_text.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.index});

  final OrderDTO order;
  final int index;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          CreateRoutes.slideFadeIn(
              direccion: const Offset(1, 0),
              screen: OrderDetailsScreen(
                order: order,
              ))),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.03, vertical: size.height * 0.01),
        width: size.width,
        height: size.height * 0.25,
        child: _OrderCardContent(size: size, index: index, order: order),
      ),
    );
  }
}

class _OrderCardContent extends StatelessWidget {
  const _OrderCardContent({
    required this.size,
    required this.index,
    required this.order,
  });

  final Size size;
  final int index;
  final OrderDTO order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderHeaderCard(index: index, size: size, order: order),
          const Divider(thickness: 2, color: Colors.white),
          OrderLinesWidget(orderLines: order.orderLines),
          const Divider(thickness: 2, color: Colors.white),
          OrderStateCost(order: order)
        ],
      ),
    );
  }
}
