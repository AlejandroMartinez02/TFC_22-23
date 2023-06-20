import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import 'addtocart_button.dart';
import 'product_price.dart';

class ProductBottomBar extends StatelessWidget {
  final double cost;
  const ProductBottomBar({super.key, required this.cost});

  @override
  Widget build(BuildContext context) {
    return FadeInUpBig(
      duration: Constants.componentAnimationDuration,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProductPrice(price: cost),
            const AddToCartButton(),
          ],
        ),
      ),
    );
  }
}
