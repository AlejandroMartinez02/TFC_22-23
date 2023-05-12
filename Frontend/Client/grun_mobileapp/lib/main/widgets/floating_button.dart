import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/widgets/create_route.dart';
import 'actual_order/actual_order_screen.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Constants.secondaryColor,
      onPressed: () {
        Navigator.push(
            context,
            CreateRoutes.slideFadeIn(
                direccion: const Offset(1, 1),
                screen: const ActualOrderScreen()));
      },
      child: const Icon(Icons.shopping_cart),
    );
  }
}
