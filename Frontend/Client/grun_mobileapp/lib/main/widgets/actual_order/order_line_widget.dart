import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../menu/domain/entity/order_line_dto.dart';
import '../../../menu/ui/menu_provider.dart';
import '../../../utils/constants.dart';

class ActualOrderLineWidget extends StatelessWidget {
  const ActualOrderLineWidget({super.key, required this.orderLine});

  final OrderLineDTO orderLine;
  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);

    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: size.width < 600 ? 22 : 26);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'x ${orderLine.count}\t${orderLine.product.name}',
              style: bodyLarge,
            ),
            Text(
              '${orderLine.cost.toStringAsFixed(2)}€',
              style: bodyLarge,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                color: Colors.black,
                onPressed: () {
                  menuProvider.removeProductCount(orderLine: orderLine);
                },
                icon: const Icon(
                  FontAwesomeIcons.minus,
                  color: Constants.secondaryColor,
                )),
            IconButton(
                color: Colors.black,
                onPressed: () {
                  menuProvider.addProductCount(orderLine: orderLine);
                },
                icon: const Icon(
                  FontAwesomeIcons.plus,
                  color: Constants.secondaryColor,
                ))
          ],
        ),
        Divider(thickness: 2),
        SizedBox(height: size.height * 0.02)
      ],
    );
  }
}
