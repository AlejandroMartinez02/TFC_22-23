import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/order_provider.dart';
import 'visualize_order_dialog.dart';

class VisualizeOrderOption extends StatelessWidget {
  const VisualizeOrderOption({super.key, required this.rowIndex});

  final int rowIndex;
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            orderProvider.currentOrderIndex = rowIndex;
            return VisualizeOrderDialog(
                bodyLarge: bodyLarge, order: orderProvider.orders[rowIndex]);
          }),
      child: Container(
        color: Constants.blueColor,
        child: const Icon(
          FontAwesomeIcons.eye,
          color: Colors.white,
        ),
      ),
    );
  }
}
