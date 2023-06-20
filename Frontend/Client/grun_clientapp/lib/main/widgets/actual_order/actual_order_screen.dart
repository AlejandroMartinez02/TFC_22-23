import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../menu/domain/entity/order_line_dto.dart';
import '../../../menu/ui/menu_provider.dart';
import '../../../utils/constants.dart';
import 'order_bottom_bar.dart';
import 'order_line_widget.dart';

class ActualOrderScreen extends StatelessWidget {
  const ActualOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainColor = Theme.of(context).primaryColor;
    final menuProvider = Provider.of<MenuProvider>(context);
    final order = menuProvider.order;
    return Scaffold(
        bottomNavigationBar: order.orderLines.isEmpty
            ? null
            : OrderBottomNavigation(cost: order.totalCost),
        appBar: AppBar(
          title: Text(
            Constants.orderSummary,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: size.width < 600 ? 28 : 32),
          ),
          backgroundColor: mainColor,
          toolbarHeight: size.height * 0.1,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(
                left: size.width * 0.05, right: size.width * 0.05),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                order.orderLines.isEmpty
                    ? Text(Constants.noProductsAvailable,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black,
                            fontSize: size.width < 600 ? 22 : 26))
                    : OrderLinesColumn(
                        orderLines: order.orderLines,
                        size: size,
                      )
              ],
            ),
          ),
        ));
  }
}

class OrderLinesColumn extends StatelessWidget {
  const OrderLinesColumn(
      {super.key, required this.orderLines, required this.size});
  final List<OrderLineDTO> orderLines;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...orderLines.map((e) => ActualOrderLineWidget(
              orderLine: e,
            ))
      ],
    );
  }
}
