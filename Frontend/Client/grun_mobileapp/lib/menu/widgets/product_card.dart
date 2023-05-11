import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grun_mobileapp/menu/domain/entity/entity.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import '../../main/ui/product_screen.dart';
import '../../utils/utils.dart';
import '../../main/domain/entity/products_dto.dart';
import '../ui/menu_provider.dart';

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
    final menuProvider = Provider.of<MenuProvider>(context);
    return GestureDetector(
      onTap: () {
        menuProvider.newOrderLine =
            OrderLineDTO(product: product, count: 1, cost: product.cost);
        Navigator.push(
            context,
            CreateRoutes.slideFadeIn(
                direccion: const Offset(0, 1),
                screen: ProductScreen(product: product)));
      },
      child: Container(
        height: size.height * 0.2,
        width: size.width * 0.9,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), color: primaryColor),
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _ContainerTitle(
                            child: AutoSizeText(product.name,
                                maxLines: 1,
                                minFontSize: size.width < 600 ? 18 : 22,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: size.width < 600 ? 22 : 24,
                                    ),
                                overflowReplacement: Marquee(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  pauseAfterRound: const Duration(seconds: 2),
                                  startPadding: 18.0,
                                  blankSpace: size.width < 600 ? 14 : 18,
                                  accelerationDuration:
                                      const Duration(seconds: 1),
                                  accelerationCurve: Curves.easeInCubic,
                                  decelerationDuration:
                                      const Duration(milliseconds: 500),
                                  decelerationCurve: Curves.easeOutCubic,
                                  text: product.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: size.width < 600 ? 22 : 24,
                                      ),
                                )),
                          ),
                          Text(
                            "${product.cost}€",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: size.width < 600 ? 22 : 24,
                                    ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _ContainerDescription(
                            child: AutoSizeText(
                              product.description,
                              overflow: TextOverflow.ellipsis,
                              minFontSize: size.width < 600 ? 16 : 18,
                              maxLines: 3,
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: size.width < 600 ? 22 : 24,
                                  ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                final menuProvider = Provider.of<MenuProvider>(
                                    context,
                                    listen: false);
                                menuProvider.addToCart(product: product);
                                NotificationService.showSnackBar(
                                    "¡Producto añadido al carrito!");
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _ContainerTitle extends StatelessWidget {
  const _ContainerTitle({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      padding: EdgeInsets.only(left: size.width * 0.02),
      constraints: BoxConstraints(
          maxHeight: size.width < 600 ? 22 : 30, maxWidth: size.width),
      child: child,
    );
  }
}

class _ContainerDescription extends StatelessWidget {
  const _ContainerDescription({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      padding: EdgeInsets.only(left: size.width * 0.02),
      constraints: BoxConstraints(maxWidth: size.width),
      child: child,
    );
  }
}
