import 'package:auto_size_text/auto_size_text.dart';
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
        .copyWith(color: Colors.black, fontSize: size.width < 600 ? 18 : 22);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                  maxHeight: size.height * 0.1, maxWidth: size.width * 0.7),
              child: AutoSizeText(
                'x ${orderLine.count}\t${orderLine.product.name}',
                maxLines: 1,
                minFontSize: size.width < 600 ? 18 : 22,
                style: bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AutoSizeText(
              '${orderLine.cost.toStringAsFixed(2)}€',
              maxFontSize: size.width < 600 ? 18 : 22,
              style: bodyLarge,
              overflowReplacement: Text(
                '${orderLine.cost.toStringAsFixed(2)}€',
                style: bodyLarge.copyWith(fontSize: 14),
              ),
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
        const Divider(thickness: 2),
        SizedBox(height: size.height * 0.02)
      ],
    );
  }
}
