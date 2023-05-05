import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grun_mobileapp/main/domain/entity/products_dto.dart';
import 'package:grun_mobileapp/main/ui/product_screen.dart';
import 'package:grun_mobileapp/utils/constants.dart';
import 'package:grun_mobileapp/utils/services/notification_service.dart';
import 'package:grun_mobileapp/utils/widgets/create_route.dart';
import 'package:marquee/marquee.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductDTO product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      height: size.height * 0.2,
      width: size.width * 0.9,
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            CreateRoutes.SlideFadeIn(
                direccion: Offset(0, 1),
                screen: ProductScreen(product: product))),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), color: primaryColor),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Hero(
              tag: product.id!,
              child: CachedNetworkImage(
                height: size.height * 0.15,
                width: size.width * 0.25,
                imageUrl: product.photo,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  "assets/foodLoader.gif",
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/no-image.png", fit: BoxFit.cover),
              ),
            ),
            Container(
              width: size.width * 0.5,
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: size.height * 0.02),
                    constraints: BoxConstraints(
                        maxHeight: size.width < 600 ? 20 : 30,
                        maxWidth: size.width),
                    child: AutoSizeText(product.name,
                        maxLines: 1,
                        minFontSize: size.width < 600 ? 20 : 24,
                        style: nameStyle(size),
                        overflowReplacement: Marquee(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          pauseAfterRound: const Duration(seconds: 2),
                          startPadding: 18.0,
                          blankSpace: size.width < 600 ? 14 : 18,
                          accelerationDuration: const Duration(seconds: 1),
                          accelerationCurve: Curves.easeInCubic,
                          decelerationDuration:
                              const Duration(milliseconds: 500),
                          decelerationCurve: Curves.easeOutCubic,
                          text: product.name,
                          style: nameStyle(size),
                        )),
                  ),
                  AutoSizeText(
                    product.description,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: size.width < 600 ? 16 : 18,
                    maxLines: 4,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontFamily: 'Paralucent'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${product.cost}€",
                    style: nameStyle(size),
                  ),
                  IconButton(
                      onPressed: () {
                        NotificationService.showSnackBar(
                            "¡Producto añadido al carrito!");
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ))
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  TextStyle nameStyle(Size size) {
    return TextStyle(
        fontSize: size.width < 600 ? 22 : 24,
        fontFamily: 'Paralucent',
        fontWeight: FontWeight.bold);
  }
}
