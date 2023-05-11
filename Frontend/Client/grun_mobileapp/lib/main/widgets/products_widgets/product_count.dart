import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../menu/ui/menu_provider.dart';
import '../../../utils/constants.dart';

class ProductCount extends StatelessWidget {
  const ProductCount({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final menuProvider = Provider.of<MenuProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: Constants.secondaryColor,
          borderRadius: BorderRadius.circular(Constants.borderRadius)),
      height: size.height * 0.05,
      width: size.width * 0.2,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              menuProvider.removeCountNewOrderLine();
            },
            icon: const Icon(
              FontAwesomeIcons.minus,
              color: Colors.white,
            )),
        Text(
          "${menuProvider.newOrderLine.count}",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white, fontSize: size.width < 600 ? 12 : 22),
        ),
        IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              menuProvider.addProductCountNewOrderLine();
            },
            icon: const Icon(
              FontAwesomeIcons.plus,
              color: Colors.white,
            )),
      ]),
    );
  }
}
