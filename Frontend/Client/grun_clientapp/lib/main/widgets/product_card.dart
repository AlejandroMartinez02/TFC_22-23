// ignore_for_file: camel_case_types
import 'package:auto_size_text/auto_size_text.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../menu/domain/entity/order_line_dto.dart';
import '../../menu/ui/menu_provider.dart';
import '../../utils/utils.dart';
import '../../utils/widgets/card/background_image_card.dart';
import '../domain/entity/products_dto.dart';
import '../ui/product_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductDTO product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final menuProvider = Provider.of<MenuProvider>(context);
    return GestureDetector(
      onTap: () {
        menuProvider.newOrderLine =
            OrderLineDTO(cost: product.cost, count: 1, product: product);
        Navigator.push(
            context,
            CreateRoutes.slideFadeIn(
                direccion: const Offset(1, 0),
                screen: ProductScreen(product: product)));
      },
      child: Container(
        width: size.width < 600 ? 275 : 350,
        decoration: _cardDecoration(),
        child: Hero(
          tag: product.id!,
          child: Stack(children: [
            BackgroundImage(
              photo: product.photo,
            ),
            _cardTitle(
              title: product.name,
            )
          ]),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(0, 2))
        ],
        color: Colors.white);
  }
}

class _cardTitle extends StatelessWidget {
  final String title;

  const _cardTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(15),
        child: Material(
          type: MaterialType.transparency,
          borderOnForeground: false,
          child: AutoSizeText(
            title.toUpperCase(),
            minFontSize: size.width < 600 ? 22 : 24,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: size.width < 600 ? 22 : 24,
                ),
            overflowReplacement: Marquee(
              crossAxisAlignment: CrossAxisAlignment.end,
              pauseAfterRound: const Duration(seconds: 2),
              startPadding: 18.0,
              blankSpace: 22,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.easeInCubic,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOutCubic,
              text: title.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: size.width < 600 ? 22 : 24,
                  ),
            ),
          ),
        ));
  }
}
