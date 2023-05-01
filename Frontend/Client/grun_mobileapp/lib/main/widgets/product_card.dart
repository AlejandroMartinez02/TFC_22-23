// ignore_for_file: camel_case_types
import 'package:grun_mobileapp/main/ui/product_screen.dart';
import 'package:grun_mobileapp/utils/widgets/card/card_widgets.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter/material.dart';

import 'package:grun_mobileapp/main/domain/entity/products_dto.dart';
import 'package:grun_mobileapp/utils/utils.dart';

class ProductCard extends StatelessWidget {
  final ProductDTO product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width < 600 ? 275 : 350,
      decoration: _cardDecoration(),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            CreateRoutes.SlideFadeIn(
                direccion: const Offset(1, 0),
                screen: ProductScreen(product: product))),
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
      child: title.length < 19
          ? Text(
              title.toUpperCase(),
              textAlign: TextAlign.left,
              style: _textStyle(size),
            )
          : Marquee(
              crossAxisAlignment: CrossAxisAlignment.end,
              pauseAfterRound: const Duration(seconds: 2),
              startPadding: 18.0,
              blankSpace: 22,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.easeInCubic,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOutCubic,
              text: title.toUpperCase(),
              style: _textStyle(size),
            ),
    );
  }

  TextStyle _textStyle(Size size) {
    return TextStyle(
        fontSize: size.width < 600 ? 22 : 24,
        color: Colors.white,
        fontFamily: 'Paralucent',
        fontWeight: FontWeight.w600);
  }
}
