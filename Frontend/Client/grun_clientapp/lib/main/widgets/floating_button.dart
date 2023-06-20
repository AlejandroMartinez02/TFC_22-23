import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../menu/ui/menu_provider.dart';
import '../../utils/constants.dart';
import '../../utils/widgets/create_route.dart';
import 'actual_order/actual_order_screen.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    return FloatingActionButton.extended(
      backgroundColor: Constants.secondaryColor,
      onPressed: () {
        Navigator.push(
            context,
            CreateRoutes.slideFadeIn(
                direccion: const Offset(1, 1),
                screen: const ActualOrderScreen()));
      },
      label: Row(
        children: [
          const Icon(Icons.shopping_cart),
          if (menuProvider.productCount != 0)
            Text(
              menuProvider.productCount > 99
                  ? '99+'
                  : menuProvider.productCount.toString(),
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
            )
        ],
      ),
    );
  }
}
